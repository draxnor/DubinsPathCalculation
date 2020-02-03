close all;

figure(1); hold on; grid on;
q1 = VehicleState(5,3,pi/2.6);
q2 = VehicleState(4,4,pi/3.6);
% q1 = VehicleState(1,3,pi/2);
% q2 = VehicleState(1,4,pi/2);

q1.RightCirclePlot();
q1.LeftCirclePlot();
q1.StatePlot();

q2.RightCirclePlot();
q2.LeftCirclePlot();
q2.StatePlot();

try
%     RSL_Path(q1,q2);
%     LSR_Path(q1,q2);
     RSR_Path(q1,q2);
     LSL_Path(q1,q2);
%     RLR_Path(q1,q2);
 %   LRL_Path(q1,q2);
catch ME
    msg=ME.message
end
% 
% 
% q3 = VehicleState(1,1,pi);
% q3.StatePlot();
% 
% try
%     RSL_Path(q2,q3);
%     LSR_Path(q2,q3)
% catch ME
%     msg=ME.message
% end
    
axis equal