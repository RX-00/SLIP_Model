function [position, isterminal, direction] = flightToStance(t, q, s)
% FLIGHTTOSTANCE Detect when flight changes to stance
%   If the y coordinate is equal to the y touchdown (td) value then you
%   know you have hit the ground. given the touchdown angle
    
    ytd = s.d0 * sin(s.theta);
    position = q(3) - ytd;     % detect height = touchdown height
    isterminal = 1;   % stop the integration
    
    direction = -1;
end