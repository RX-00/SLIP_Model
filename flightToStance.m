function [value, isTerminal, stance] = flightToStance(t, q)
% FLIGHTTOSTANCE Detect when flight changes to stance
%   If the y coordinate is equal to the y touchdown (td) value then you
%   know you have hit the ground. given the touchdown angle
    value = y(1);     % detect height = 0
    isTerminal = 1;   % stop the integration
    direction = -1;   % negative direction
end