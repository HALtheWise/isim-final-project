
% SEE: http://www.mathworks.com/help/daq/examples/getting-started-acquiring-data-with-digilent-analog-discovery.html

s = daq.createSession('digilent')

ch = addAnalogInputChannel(s,'AD1', 1, 'Voltage')
ch2 = addAnalogInputChannel(s,'AD1', 2, 'Voltage')

%pause

[singleReading, triggerTime] = s.inputSingleScan

packetLength = .2; %seconds of measurement

rate = 400e3;

close all
figure
ax1 = subplot(1,2,1);
global ax2
ax2 = subplot(1,2,2);

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
    
    if TransmitTimes(1)
        continue
    end
    
    tID = find(TransmitTimes, 1);
    if isempty(tID) || length(timestamps) - tID <= mSig
        disp('Transmission not detected')
        continue 
    end
    tTime = timestamps(tID);
    
    
    [echoTime2, echoAmp2] = detect_echo(timestamps(tID:tID+mSig)-tTime,...
        data(tID:tID+mSig,2))
    
    [echoTime1, echoAmp1] = detect_echo(timestamps(tID+mSig : tID+2*mSig)...
        -tTime-(1/mFreq),...
        data(tID+mSig : tID+2*mSig,2))
    

    if isempty(echoTime1) || isempty(echoTime2)
        disp('Missing echo')
        continue
    end
    
    mach1 = 340.29; %m/s
    timeOffset = 2e-4;
    d = 0.13; % Distance from origin to transmitters
    
    r1 = (echoTime1-timeOffset)*mach1
    r2 = (echoTime2-timeOffset)*mach1
    
    pos = calcPos(r1, r2, d)
    
    if imag(pos(2))
        disp('position imaginary')
        continue
    end
    
    transmitter1 = [-d, 0];
    delta = pos - transmitter1;
    theta1 = atan2d(delta(2), delta(1))
    
    expected_strength = base_amplitude(r1)
    angleCompFactor = echoAmp1 / expected_strength % Should be less than 1
    
    detectedAngle = angleFromStrength(angleCompFactor)
    absoluteAngle = theta1+detectedAngle - 90
    
    plot(ax1, pos(1), pos(2), '*', 'MarkerEdgeColor', hsv2rgb([mod(5*absoluteAngle+90, 360)/360 1 1]), 'MarkerSize', 15);
    
    hold(ax1, 'on')
    axis(ax1, 'equal')
    xlim(ax1, .2*[-1 1]);
    plot(ax2, [pos(1) pos(1)+.2*sind(absoluteAngle)], [pos(2) pos(2)-.2*cosd(absoluteAngle)]) %angle tick
    
%     plot(timestamps, data);
%     plot(timestamps, TransmitTimes);
%     
%     if not(isempty(tTime))
%         plot((timestamps(tID))*[1 1], [-3 3], 'k');
%         plot((timestamps(tID+mSig))*[1 1], [-3 3], 'k');
%     end
%     
%     xlabel('Time (seconds)')
%     ylabel('Voltage (Volts)')
%     title(['Clocked Data Triggered on: ' datestr(triggerTime)])
%     legend('1', '2', 'transmitTimes')
    
    
    %keyboard
    
end