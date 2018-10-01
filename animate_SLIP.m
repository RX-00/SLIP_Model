function [] = animate_SLIP(q, s, t)
%ANIMATE_SLIP animate the SLIP model
%   Take in the state vector and forces to model the SLIP model

    fig = figure(56); % TODO: Figure out this whole animation process thing
    cla
    xlim([-0.5, 0.5]);
    ylim([-0.3, 2]);
    grid on;
    axis equal;
    title('SLIP Animation');
    xlabel('distance');
    ylabel('height');
    
    % used to calculate the leg length
    x = q(1, 1);
    y = q(1, 3);
    xtd = q(1, 5);
    ytd = 0;
    d = sqrt((x - xtd)^2 + (y)^2);
    
    % Visual patches
    ground_patch = patch([-50, -50, 50, 50], [0, -10, -10, 0], [0.5, 0.5, 0.5]);
    body_patch = patch(q(1, 1) + 0.1 * sin(0: 0.1: 2 * pi), q(1, 3) + 0.1 * cos(0: 0.1: 2 * pi), [70, 216, 226]./255);
    leg_patch = patch(q(1, 1) + [0.01,0.01,-0.01,-0.01]*cos(s.theta) + d * [0,1,1,0]*sin(s.theta),...);
        q(1, 3) - [0.01,0.01,-0.01,-0.01] * sin(s.theta) + d * [0,-1,-1,0] * cos(s.theta), 'k');
    
    % Loop through the data and update the graphics
    for i = 1:length(t)
        body_patch.Vertices = [q(i, 1) + 0.1 * sin(0: 0.1: 2 * pi); q(i, 3) + 0.1 * cos(0: 0.1: 2 * pi)]';
        
        % used to calculate the leg length
        x = q(i, 1);
        y = q(i, 3);
        xtd = q(i, 5);
        ytd = 0;
        d = sqrt((x - xtd)^2 + (y)^2);
        
        leg_patch.Vertices = [q(i, 1) + [0.01,0.01,-0.01,-0.01] * cos(s.theta) + d * [0,1,1,0] * sin(s.theta);...);
                       q(i, 3) + [0.01,0.01,-0.01,-0.01] * sin(s.theta) + d * [0,-1,-1,0] * cos(s.theta)]';
        
        ylim([-2, 2]);
        
        % Increment the screen by 0.5 m increments
        xlim([-1.5, 1.5] + round(q(i, 1) * 2) / 2);
        
        drawnow;
        %pause(0.1);
    end
end

