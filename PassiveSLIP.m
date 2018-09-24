function dy = PassiveSLIP(theta, dDef, k, m)
% ATTEMPTSLIP attempt at a passive SLIP model by Roy X.
% Find (x, y) of the point mass!
    
    % Do I need these here?
    xtd = 0;
    ytd = 0;
    
    % Initial values of COM's x & y, do I even need these given y0 is a
    % thing?
    x = 0;
    y = h0;
    g = 9.8;
    
    % This is probably for flight phase and probably shouldn't be here with
    % stance stuff
    h = h0; % h is equal to the highest value of y during the sim. Not sure the proper way to find that yet
    
    % Functions that describe the motion of the SLIP Model's COM
    d = sqrt((x - xtd)^2 + (y - ytd)^2);
    sinT = y / d;
    cosT = abs(xtd - x) / d;
    Fs = k * (dDef - d);
    Fy = Fs * sinT;
    Fx = Fs * cosT;
    Fyt = Fs * sinT - g;
    
    %d = d0 in flight phase, not sure how to impliment/express that just
    %yet
    
    
    dy(1, 1) = y(2); % Is this correct? Why is y(2) here like that and what's up with the inputs of dy
    dy(2, 1) = (m / Fx);
    dy(3, 1) = y(4);
    dy(4, 1) = (m / Fyt); % Would Fyt be correct here instead of Fy?
    

