% Plot the trajectory of the point mass of the SLIP model
clear all, close all, clc

% input struct for all the chosen variables and parameters for the physics
% equations
input.theta = [0, 45];
input.dDef = 0.2;
input.k = 100;
input.m = 10;
input.g = 9.81;

y0 = [0; 5; 5; -9.8]; % Starting conditions of the state vector x, y, fwrd vel, upwrd vel

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

tspan = 0:.1:100; % 5 sec should be enough, but why does the graph increase at 100?

% Flight function
%function dydt = f(t, y, input)
%dydt = [y(2); -9.8; ]

% Stance function
stanceDyn = @(t, y) PassiveSLIP(t, y, input);

[t, y] = ode45(stanceDyn, tspan, y0);
%[t, y, te, ye, ie] = ode45(stanceDyn, tspan, y0, options);

% for i = 1 : 100
    % Plot the x and y coordinates of the SLIP model's COM
% end

plot(t, y(:,1));
xlabel('distance');
ylabel('height');
title('SLIP Model COM Trajectory');
hold off

