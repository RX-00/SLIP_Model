% Plot the trajectory of the point mass of the SLIP model
clear; close all; clc

% input struct for all the chosen variables and parameters for the physics
% equations
input.theta = [0, 45];
input.d0 = 0.9; % Changed dDef to d0 since it's just better notation
input.k = 100;
input.m = 10;
input.g = 9.81;

q0 = [0; 1; 1; -6]; % Starting conditions of the state vector x, y, fwrd vel, upwrd vel

refine = 4;
options = odeset('Events', @events, 'OutputFcn', @odeplot, 'OutputSel', 1, ...
    'Refine', refine);

% graph stuff
% fig = figure;
% ax = axes;
% ax.XLim = [0 10];
% ax.YLim = [0 10];
% box on
% hold on;

tspan = [0 5]; % 5 sec should be enough, but why does the graph increase at 100?

% Flight function
flightDyn = @(t, q) SLIP_Flight(t, q, input);

% Stance function
stanceDyn = @(t, q) SLIP_Stance(t, q, input);

%[t, q] = ode45(stanceDyn, tspan, q0);
[t, q] = ode45(flightDyn, tspan, q0);
%[t, y, te, ye, ie] = ode45(stanceDyn, tspan, y0, options);

% for i = 1 : 100
    % Plot the x and y coordinates of the SLIP model's COM
% end

plot(q(:,1), q(:,3));
xlabel('distance');
ylabel('height');
title('SLIP Model COM Trajectory');
hold off

