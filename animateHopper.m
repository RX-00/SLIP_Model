function [] = animateHopper(dyn,groundforce)
	%UNTITLED6 Summary of this function goes here
	%   Detailed explanation goes here
	
	fig = figure(56);
	
	subplot(2,2,1)
	
	axis([-1.5,1.5,0,2.5])
	axis square
% 	groundpatch = patch([-10,10,-10,10],[0,0,-10,-10],[1,1,1]*0.9);
	bodyx = [-1,1,1,-1]'*.5;
	bodyy = [0,0,1.37,1.37]'*.5;
	
	
% 	motorx = [-1,1,1,-1]'*0.15;
% 	motory = [-1,-1,1,1]'*0.05;
	
	toex = [-1,1,1,-1]'*0.1;
	toey = [0,0,1,1]'*.1;
	
	bodyPatch = patch(bodyx,bodyy,[1,1,1]*0.8);
% 	motorPatch = patch(motorx,motory,[1,1,1]*0.4);
	toePatch = patch(toex,toey,[1,1,1]*0.6);
	
% 	subplot(1,2,2)
% 	hold off
% % 	tracedBodyPlotinvis = plot(y(1,:),y(4,:),'-w');
% 	hold on
% % 	tracedBodyPlot = plot(dyn(:,2), dyn(:,4) ,'-b');
%   
% 	bodyPoint = plot(dyn(:,1),dyn(:,3),'-r');
% 	grid on
% 	ylabel('Body Velocity');
% 	xlabel('Body Position');
	
	fig.Position = [2084 296 1280 720];
	v = VideoWriter('newfile');
	v.Quality = 80;
	v.FrameRate = 60;
	open(v);
	time = dyn(:,1);
    bodposition = dyn(:,2);
    bodvelocity = dyn(:,3);
    footposition = dyn(:,4);
    footvelocity = dyn(:,5);
    groundforcey = groundforce(:,2);
	for i = 1:2:length(dyn(:,1))
	   bodyPatch.YData = bodyy + dyn(i,2); 
% 	   motorPatch.YData = motory + 0.5 + y(1,i) - y(2,i); 
	   toePatch.YData = toey + dyn(i,4); 
	   
	   tracedBodyPlot.XData = dyn(i,2);
	   tracedBodyPlot.YData = dyn(i,4);
       subplot(2,2,2) 
       plot(time(1:i),bodposition(1:i),'-r');
       hold on
       plot(time(1:i),footposition(1:i),'-b');
       axis([0 1.5 0 1.5])
       xlabel('Time (s)');
       ylabel('Height (m)');
%        axis square
       subplot(2,2,3)
       plot(time(1:i),bodvelocity(1:i),'-r');
       grid on
	   ylabel('Body Velocity (m/s)');
	   xlabel('Time (s)');
% 	   bodyPoint.XData = dyn(i,1);
% 	   bodyPoint.YData = dyn(i,3);
       axis([0 1.5 -3 3])
%        axis square
       subplot(2,2,4)
       plot(time(1:i),groundforcey(1:i),'-g');
	   axis([0 1.5 0 1000])
       xlabel('Time (s)')
       ylabel('Ground Force (N)')
%        axis square
	   drawnow();    
	   frame = getframe(fig);
	   writeVideo(v,frame);
	end
	
	v.close();