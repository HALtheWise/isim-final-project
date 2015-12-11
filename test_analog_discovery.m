
% SEE: http://www.mathworks.com/help/daq/examples/getting-started-acquiring-data-with-digilent-analog-discovery.html

s = daq.createSession('digilent')

ch = addAnalogInputChannel(s,'AD1', 1, 'Voltage')
ch2 = addAnalogInputChannel(s,'AD1', 2, 'Voltage')

pause

[singleReading, triggerTime] = s.inputSingleScan


while 1
    pause

    s.Rate = 300e3;
    s.Channels(1).Range = [-2.5 2.5];
    s.Channels(2).Range = [-2.5 2.5];
    s.DurationInSeconds = 0.1

    [data, timestamps, triggerTime] = s.startForeground;

    plot(timestamps, data);
    xlabel('Time (seconds)')
    ylabel('Voltage (Volts)')
    title(['Clocked Data Triggered on: ' datestr(triggerTime)])
    legend('1', '2')
    
    keyboard
end