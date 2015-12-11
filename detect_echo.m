function [ time, amplitude ] = detect_echo( Timestamps, Echochannel )
%DETECT_ECHO Summary of this function goes here
%   Detailed explanation goes here
    
    cutoff_mult = 0.5;

    amplitude = max(Echochannel);
    time = Timestamps(find(Echochannel >= cutoff_mult*amplitude, 1));
end

