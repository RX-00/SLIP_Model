function dy = PassiveSLIP(h0, xVelStart, theta, dDef, k, m)
% ATTEMPTSLIP attempt at a passive SLIP model by Roy X.
% Find (x, y) of the point mass!
    
    xtd, ytd = 0; % Both y and x touchdown points are x = 0
    % Initial values of COM's x & y
    x = 0;
    y = h0;
    g = 9.8;
    fig = figure;
    ax = axes;
    ax.XLim = [0 50];
    ax.YLim = [0 40];
    h = h0; % h is equal to the highest value of y during the sim. Not sure the proper way to find that yet
    
    % Functions that describe the motion of the SLIP Model's COM
    
    Fs = k * (dDef - d);
    Fy = Fs * sin(theta); % How to express as m * y double dot?
    Fx = Fs * cos(theta); % How to express as m * x double dot?
    Fyt = Fs * sin(theta) - g;
    %d = sqrt((m * g * h) / (0.5 * k));
    d = y / sin(theta);
    %d = d0 in flight phase, not sure how to impliment/express that just
    %yet
    
    
    % TODO: figure out how to express the state vector here, how to
    % write/express x, x dot, y, y dot
    % what do to with the whole fact that the state vector as a derivative
    % of time?
    dy(1, 1) = y(2); % Named function y due to standard MATLAB Convention? Check if this is proper
    dy(2, 1) = (); % How to write x double dot here?
    dy(3, 1) = y(4);
    dy(4, 1) = ();
    

