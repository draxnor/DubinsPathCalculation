function [distance] = RLR_Path(q1,q2)
%RLR_PATH Summary of this function goes here
%   q1 - stan poczatkowy
%   q2 - stan startowy

%sciezka C1->S->C2
%C1 - okrag wytaczany przy zakrecie z pozycji poczatkowej
%C2 - okrag wytaczany przy zakrecie do pozycji koncowej

R = q1.R;  % bo klasa VehicleState nie powinna zawierac pola obj.R
C1 = q1.RightCircleCalc();
C2 = q2.RightCircleCalc();

C1C2 = C2-C1;
if norm(C1C2) > 4*R
    ME = MException('PathError:TooFarForCCCPath', '|C1C2|>4R, sciezka RLR niewykonalna');
    throw(ME);
end
inv_distC1C2 = 1/norm(C1C2); % dla przyspieszenia

%Wyznaczone wektorowo
C3=C1+C1C2/2+([0,1;-1,0]*C1C2'*inv_distC1C2*sqrt(4*R*R-(norm(C1C2)^2)/4))';
    
T1=C1+(C3-C1)/2;
T2=C2+(C3-C2)/2;

C1q1=[q1.XPos,q1.YPos]-C1;
C1T1=T1-C1;
C3T1=T1-C3;
C3T2=T2-C3;
C2T2=T2-C2;
C2q2=[q2.XPos,q2.YPos]-C2;

% kat skierowany w poz 1 (q1) na okregu C1
C1_angle1=atan2_0to2pi( C1q1(:,2), C1q1(:,1));
% kat skierowany w poz 2 (T1) na okregu C1
C1_angle2=atan2_0to2pi( C1T1(:,2), C1T1(:,1));

% kat skierowany w poz 1 (T1) na okregu C3
C3_angle1=atan2_0to2pi( C3T1(:,2), C3T1(:,1));
% kat skierowany w poz 2 (T2) na okregu C3
C3_angle2=atan2_0to2pi( C3T2(:,2), C3T2(:,1));

% kat skierowany w poz 1 (T2) na okregu C2
C2_angle1=atan2_0to2pi( C2T2(:,2), C2T2(:,1));
% kat skierowany w poz 2 (q2) na okregu C2
C2_angle2=atan2_0to2pi( C2q2(:,2), C2q2(:,1));

%laczny kat obrotu na C1 (obrot w prawo)
C1_alfa=mod(C1_angle1-C1_angle2+2*pi,2*pi);
%laczny kat obrotu na C3 (obrot w lewo)
C3_alfa=mod(C3_angle2-C3_angle1+2*pi,2*pi);
%laczny kat obrotu na C2 (obrot w prawo)
C2_alfa=mod(C2_angle1-C2_angle2+2*pi,2*pi);

distance = R*(C1_alfa+C2_alfa+C3_alfa);

%%wyswietlanie sciezki
figure(1);hold on;

%C1->C3->C2
drawArc(C1,C1_angle2,C1_angle1,R); %luk na okregu C1
drawArc(C3,C3_angle1,C3_angle2,R); %luk na okregu C3
drawArc(C2,C2_angle2,C2_angle1,R); %luk na okregu C2

end

