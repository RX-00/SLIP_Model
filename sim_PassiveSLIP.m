% Plot the trajectory of the point mass of the SLIP model
clear; close all; clc

% input struct for all the chosen variables and parameters for the physics
% equations
input.theta = 5 * pi / 4;
input.d0 = 0.9; % Changed dDef to d0 since it's just better notation
input.k = 100;
input.m = 10;
input.g = 9.81;

phase = 0; % 0 for flight, 1 for stance

% Starting conditions of the state vector x, fwrd vel, y, upwrd vel,
% foot position upon touchdown, and what phase you're in (0 for flight, 1
% for stance)
q0 = [0; 0.01; 1; 0; 0; 0];

refine = 4;

flightEvent = @(t, q) flightToStance(t, q, input);
stanceEvent = @(t, q) stanceToFlight(t, q, input);

% due to the plot here ode plots everytime by itself, helps see what's
% going on inbetween
optionsFlight = odeset('Events', flightEvent, 'OutputFcn', @odeplot, 'OutputSel', 1, ...
    'Refine', refine);
optionsStance = odeset('Events', stanceEvent, 'OutputFcn', @odeplot, 'OutputSel', 1, ...
    'Refine', refine);

% graph stuff
% fig = figure;
% ax = axes;
% ax.XLim = [0 10];
% ax.YLim = [0 10];
% box on
% hold on;

% time stuff
tspan = [0 5];
tstart = tspan(1);
tend = tspan(end);
twhile = tstart; % global solution time

tout = []; % gather up time
qout = []; % gather up state vectors

% These are not used yet
teout = []; % time when events occur
qeout = []; % state when events occur
ieout = []; % phase which event trigger the switch

% Flight function
flightDyn = @(t, q) SLIP_Flight(t, q, input);

% Stance function
stanceDyn = @(t, q) SLIP_Stance(t, q, input);

% Old tests of stance and flight isolated
%[t, q] = ode45(stanceDyn, tspan, q0);
%[t, q] = ode45(flightDyn, tspan, q0);

while isempty(tout) || tout(end) < tend
    if q0(6) == 0
        optionsFlight = odeset('Events', flightEvent, 'OutputFcn', @odeplot, 'OutputSel', 1, ...
    'Refine', refine);
        [t, q, te, qe, ie] = ode45(flightDyn, [tstart(end) tend], q0, optionsFlight);
        tstart = t;
        q(end, 5) = q(end,1) - input.d0 * cos(input.theta); % based on chosen theta
        q(end, 6) = 1;
        q0 = q(end,:);
        
        % Accumulate output
        nt = length(t);
        tout = [tout; t(2:nt)];
        qout = [qout; q(2:nt,:)];
        teout = [teout; te];
        qeout = [qeout; te];
        ieout = [ieout; te];
    else
        optionsStance = odeset('Events', stanceEvent, 'OutputFcn', @odeplot, 'OutputSel', 1, ...
    'Refine', refine);
        [t, q, te, qe, ie] = ode45(stanceDyn, [tstart(end) tend], q0, optionsStance);
        tstart = t;
        q(end, 6) = 0;
        q0 = q(end,:);
                
        % Accumulate output
        nt = length(t);
        tout = [tout; t(2:nt)];
        qout = [qout; q(2:nt,:)];
        teout = [teout; te];
        qeout = [qeout; te];
        ieout = [ieout; te];
    end
end

plot(qout(:,1), qout(:,3));

%plot(q(:,1), q(:,3));

xlabel('distance');
ylabel('height');
title('SLIP Model COM Trajectory');
hold off

