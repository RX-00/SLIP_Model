function [position, isterminal, direction] = flightToStance(t, q, s)
% FLIGHTTOSTANCE Detect when flight changes to stance
%   If the y coordinate is equal to the y touchdown (td) value then you
%   know you have hit the ground. given the touchdown angle
    
    % TODO: FIX THIS AS YOU'RE NOT PROPERLY TRANSITIONING FROM FLIGHT TO
    % STANCE
    if (s.d0 * sin(s.theta) <= 0 || s.d0 * sin(s.theta) == 0)
        ytd = 0; % If this equals zero then change stance
    else
        ytd = 1;
    end
    position = q(3) - ytd;     % detect height = touchdown height
    isterminal = 1;   % stop the integration
    
    direction = -1;
end