function [ pos ] = calcPos( r1, r2 )
%CALCPOS Summary of this function goes here
%   Detailed explanation goes here

    d = 0.09; % Distance from origin to transmitters
    
    
    x = (r1^2-r2^2) / (4*d);
    y = sqrt(r2^2 - (x-d)^2);

    pos = [x y];
    
    
    clf
    hold on
    axis equal
    xlim([-1 1])
    plot(r1*sin(linspace(0,2*pi))-d, r1*cos(linspace(0,2*pi)))
    plot(r2*sin(linspace(0,2*pi))+d, r2*cos(linspace(0,2*pi)))
end

