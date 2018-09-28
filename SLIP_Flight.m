function dy = SLIP_Flight(t, q, s)
% SLIP_Flight attempt at a passive SLIP model by Roy X.
% Find (x, y) of the point mass!
% This is the stance phase
% s stands for the struct of all the parameters
%
% y = [ x, x dot, y, y dot]
% NOTE: changed the y state vector name to q just for clarity
% Thus, in order to define x and y you must do
% x = y(:,1), y = y(:,3)

    dy(1, 1) = q(2); % x dot
    dy(2, 1) = 0; % x double dot
    dy(3, 1) = q(4); % y dot
    dy(4, 1) = -s.g; % y double dot
    dy(5, 1) = 0;
    %dy(6, 1) = 0;
end

