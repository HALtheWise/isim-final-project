function A = base_amplitude(r, theta)
% A = base(r, theta) estimates the base amplitude of the sound field
% at a point radius r and distance theta from the transmitter, assuming
% the reciever is pointed straight at the transmitter. Theta is in degrees

    A = 6.3; % y-intercept of calibration curve
    A = A / (r/19)^2; % distance degredation from calibration distance
    A = exp(-0.054 * theta); % Angle compensation, from calibration

end