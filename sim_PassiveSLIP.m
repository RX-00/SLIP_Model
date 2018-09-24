% Plot the trajectory of the point mass of the SLIP model
clear all, close all, clc

% TODO: Double Check if your initial conditions and numbers make physical
% sense

theta = [0, 45];
dDef = 0.2;
k = 100;
m = 10;

y0 = [0, 5, 5, -9.8]; % Starting conditions of the state vector x, y, fwrd vel, upwrd vel

refine = 4;
options = odeset('Events', @events, 'OutputFcn', @odeplot, 'OutputSel', 1, ...
    'Refine', refine);

% graph stuff
fig = figure;
ax = axes;
ax.XLim = [0 50];
ax.YLim = [0 40];
box on
hold on;

tspan = 0:.1:50; % How long the program runs, not sure if I need this

[t, y, te, ye, ie] = ode45(@(x, y)PassiveSLIP(theta, dDef, k, m), tspan, y0, options); % Need to figure out what the last two arguments do

for i = 1 : 100
    % Plot the x and y coordinates of the SLIP model's COM
end

plot([x, y]);
xlabel('distance');
ylabel('height');
title('SLIP Model COM Trajectory');
hold off