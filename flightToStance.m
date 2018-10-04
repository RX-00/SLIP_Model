function [position, isterminal, direction] = flightToStance(t, q, s)
% FLIGHTTOSTANCE Detect when flight changes to stance
%   If the y coordinate is equal to the y touchdown (td) value then you
%   know you have hit the ground. given the touchdown angle
    
    % TODO: FIX THIS AS YOU'RE NOT PROPERLY TRANSITIONING FROM FLIGHT TO
    % STANCE
    ytd = s.d0 * sin(s.theta);
    % Check for multiple triggers
    position = [q(3) - ytd, q(3)];     % detect height = touchdown height, q(3) == 0
    isterminal = [1, 1];   % stop the integration
    
    direction = [-1, ];
end