function PassiveSLIP
%ATTEMPTSLIP attempt at a passive SLIP model by Roy X.
%   Detailed explanation goes here
% Find (x, y) of the point mass!
    
    y0 = [0, 20]; %height at which the SLIP model is dropped from
    xVelStart = [0, 2]; %starting fwrd velocity of the mass
    theta = [0, 45];
    dDef = 0.2;
    k = 100;
    m = 10;
    xtd, ytd = 0; %both y and x touchdown points are x = 0
    %initial values of COM's x & y
    x = 0;
    y = y0.'; %transpose so that y is only from 0, 20
    
    fig = figure;
    ax = axes;
    ax.XLim = [0 50];
    ax.YLim = [0 40];
    box on
    hold on;
    
    
    
    plot(x, y)
    xlabel('distance');
    ylabel('height');
    title('SLIP Model COM Trajectory');
    hold off

end

