Angles = [0, 15, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80, 90];
Measurements = [2.498, 2.48, 2.2, 1.8, 1.5, 0.92, 0.58, 0.53, 0.36, 0.278, 0.13, 0.068, 0.058];

clf
hold on
plot(Angles(2:end), Measurements(2:end)); %exclude maxed-out first measurement
plot(linspace(0,90), exp(1.85)*exp(-0.054*linspace(0,90)));
xlim([0 90])