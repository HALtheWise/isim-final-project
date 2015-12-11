function [ pos ] = calcPos( r1, r2 )
%CALCPOS Summary of this function goes here
%   Detailed explanation goes here

    d = 0.09; % Distance from origin to transmitters
    
    
    x = (r2^2-r1^2) / (4*d);
    y = sqrt(r2^2 - (x-d)^2);

    pos = [x y];
end
