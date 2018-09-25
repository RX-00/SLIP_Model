function dy = PassiveSLIP(t, y, s)
% ATTEMPTSLIP attempt at a passive SLIP model by Roy X.
% Find (x, y) of the point mass!
%
% s stands for the struct of all the parameters
%
% y = [ x, x dot, y, y dot] (but vertical?)
% Thus, in order to define x and y you must do
% x = y(:,1), y = y(:,3)
    
    x = y(1);
    y1 = y(3);

    xtd = 0;
    ytd = 0;
  
    % Functions that describe the motion of the SLIP Model's COM
    d = sqrt((x)^2 + (y1)^2);
    sinT = y1 / d;
    cosT = x / d;
    Fs = s.k * (s.dDef - d);
    Fy = Fs * sinT;
    Fx = Fs * cosT;
    Fyt = Fs * sinT - s.m * s.g;
    
    dy(1, 1) = y(2); % x dot
    dy(2, 1) = (Fx / s.m);
    dy(3, 1) = y(4); % y dot
    dy(4, 1) = (Fyt / s.m);