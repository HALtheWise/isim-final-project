
% SEE: http://www.mathworks.com/help/daq/examples/getting-started-acquiring-data-with-digilent-analog-discovery.html

s = daq.createSession('digilent')

ch = addAnalogInputChannel(s,'AD1', 1, 'Voltage')
ch2 = addAnalogInputChannel(s,'AD1', 2, 'Voltage')

%pause

[singleReading, triggerTime] = s.inputSingleScan

packetLength = .2; %seconds of measurement

rate = 300e3;

while 1
    %pause

    s.Rate = rate;
    s.Channels(1).Range = [-2.5 2.5];
    s.Channels(2).Range = [-2.5 2.5];
    s.DurationInSeconds = packetLength;

    [data, timestamps, triggerTime] = s.startForeground;
    
    mFreq = 40; %hz
    mSig = rate / mFreq;
    
    
    TransmitTimes = abs(data(:,1)) > 2; % Create an array of 0's and 1's representing the points where a signal is clearly being transmitted
    
    tID = find(TransmitTimes, 1);
    if isempty(tID) || length(timestamps) - tID <= mSig
        disp('Transmission not detected')
        continue 
    end
    tTime = timestamps(tID);
    
    
    [echoTime1, echoAmp1] = detect_echo(timestamps(tID:tID+mSig)-tTime,...
        data(tID:tID+mSig,2))
    
    [echoTime2, echoAmp2] = detect_echo(timestamps(tID+mSig : tID+2*mSig)...
        -tTime-(1/mFreq),...
        data(tID+mSig : tID+2*mSig,2))
    

    mach1 = 340.29; %m/s
    timeOffset = 2.5e-4;
    pos = calcPos((echoTime1-timeOffset)*mach1, (echoTime2-timeOffset)*mach1)
    
    clf
    hold on
    plot(timestamps, data);
    plot(timestamps, TransmitTimes);
    
    if not(isempty(tTime))
        plot((timestamps(tID))*[1 1], [-3 3], 'k');
        plot((timestamps(tID+mSig))*[1 1], [-3 3], 'k');
    end
    
    xlabel('Time (seconds)')
    ylabel('Voltage (Volts)')
    title(['Clocked Data Triggered on: ' datestr(triggerTime)])
    legend('1', '2', 'transmitTimes')
    
    
    %keyboard
    
end