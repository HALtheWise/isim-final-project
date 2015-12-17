function [ absangle ] = angleFromStrength( amplitude )
%ANGLEFROMSTRENGTH Summary of this function goes here
%   Detailed explanation goes here

    absangle = log(amplitude)/-0.054;
    absangle = absangle*2.5;
end

