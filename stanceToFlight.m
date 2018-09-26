function [value, isTerminal, stance] = stanceToFlight(t, q)
% STANCETOFLIGHT Detect when stance changes to flight
%   If the spring force is zero then you know you have left the ground,
%   thus transitioning into the flight phase
    value = y(1);     % detect height = 0
    isTerminal = 1;   % stop the integration
    direction = -1;   % negative direction
end