function [ pos ] = calcPos( r1, r2, d )
%CALCPOS Summary of this function goes here
%   Detailed explanation goes here
    
    
    x = (r1^2-r2^2) / (4*d);
    y = sqrt(r2^2 - (x-d)^2);

    pos = [x y];
    
    global ax2
    
    cla(ax2)
    hold on
    axis(ax2, 'equal')
    xlim([-1 1])
    plot(ax2, r1*sin(linspace(0,2*pi))-d, r1*cos(linspace(0,2*pi)))
    plot(ax2, r2*sin(linspace(0,2*pi))+d, r2*cos(linspace(0,2*pi)))
    plot(ax2, pos(1), pos(2), '*');
    plot(ax2, 0, 0, '*');
end

