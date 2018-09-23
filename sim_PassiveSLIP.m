% Plot the trajectory of the point mass of the SLIP model
clear all, close all, clc

h0 = [0, 20]; % Height at which the SLIP model is dropped from
xVelStart = [0, 2]; % Starting fwrd velocity of the mass
theta = [0, 45];
dDef = 0.2;
k = 100;
m = 10;

box on
hold on;

tspan = 0:.1:50; % How long the program runs, not sure if I need this

[x, y] = ode45(@(x, y)PassiveSLIP(h0, xVelStart, theta, dDef, k, m), tspan, y0); % Need to figure out what the last two arguments do

for i = 1 : 100
    % Plot the x and y coordinates of the SLIP model's COM
end

plot([x, y]);
xlabel('distance');
ylabel('height');
title('SLIP Model COM Trajectory');
hold off