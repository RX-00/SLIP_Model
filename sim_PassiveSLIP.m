% sim_PassiveSLIP attempt at a passive SLIP model by Roy X.
% Find (x, y) of the point mass!
% 
% q = [ x, x dot, y, y dot]

clear; close all; clc

% input struct for all the chosen variables and parameters for the physics
% equations
input.theta = 4.5 * pi / 8;
assert(input.theta < pi, 'ERROR: Touchdown theta must not be greater than pi')
input.d0 = 0.9; % Changed dDef to d0 since it's just better notation
input.k = 2000;
input.m = 20;
input.g = 9.81;

% Starting conditions of the state vector x, fwrd vel, y, upwrd vel,
% foot position upon touchdown, and what phase you're in (0 for flight, 1
% for stance)
q0 = [0; 0.00001; 1.5; 0; 0; 0];

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
tspan = [0 20];
tStep = 0.01;
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

while isempty(tout) || tout(end) < tend - tStep
    if q0(6) == 0
        optionsFlight = odeset('Events', flightEvent, 'OutputFcn', @odeplot, 'OutputSel', 1, ...
    'Refine', refine);
        [t, q, te, qe, ie] = ode45(flightDyn, [tstart(end):tStep:tend], q0, optionsFlight);
              
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
        
        % Check if everything is alright, i.e. not y < 0
        if q(end, 3) <= 0
            % Terminate the program for the SLIP model has fallen
            fprintf('SLIP Model has fallen (y < 0) at t = %f \n', tout(end))
            break;
        end
    else
        optionsStance = odeset('Events', stanceEvent, 'OutputFcn', @odeplot, 'OutputSel', 1, ...
    'Refine', refine);
        [t, q, te, qe, ie] = ode45(stanceDyn, [tstart(end):tStep:tend], q0, optionsStance);
        
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
        
        % Check if everything is alright, i.e. not y < 0
        if q(end, 3) <= 0
            % Terminate the program for the SLIP model has fallen
            fprintf('SLIP Model has fallen (y < 0) at t = %f \n', tout(end))
            break;
        end
    end
    
end

plot(qout(:,1), qout(:,3));

xlabel('distance');
ylabel('height');
title('SLIP Model COM Trajectory');
hold off

% PLOT ALL OF YOUR DATA
animate_SLIP(qout, input, tout);