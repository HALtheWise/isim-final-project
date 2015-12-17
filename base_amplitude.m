function A = base_amplitude(r)
% A = base(r, theta) estimates the base amplitude of the sound field
% at a point radius r and distance theta from the transmitter, assuming
% the reciever is pointed straight at the transmitter. Theta is in degrees

    A = 2.1; % y-intercept of calibration curve GUESS!
    A = A / (r/.18)^2; % distance degredation from calibration distance
    %A = A*exp(-0.054 * theta); % Angle compensation, from calibration

end