function [distance] = RSL_Path(q1,q2)
%RSL_PATH Summary of this function goes here
%   q1 - stan poczatkowy
%   q2 - stan startowy

%sciezka C1->S->C2
%C1 - okrag wytaczany przy zakrecie z pozycji poczatkowej
%C2 - okrag wytaczany przy zakrecie do pozycji koncowej

R = q1.R;  % bo klasa VehicleState nie powinna zawierac pola obj.R
C1 = q1.RightCircleCalc();
C2 = q2.LeftCircleCalc();

C1C2 = C2-C1;
if norm(C1C2) < 2*R
    ME = MException('PathError:TooCloseForRSL', '|C1C2|<2R, sciezka RSL niewykonalna');
    throw(ME);
end
inv_distC1C2 = 1/norm(C1C2); % dla przyspieszenia
beta = acos(2*R*inv_distC1C2); % k¹t miedzy C1T1, a C1C2
    
T1=[C1(:,1)+C1C2(:,1)*R*cos(beta)*inv_distC1C2-C1C2(:,2)*R*sin(beta)*inv_distC1C2, ... %X_T1
    C1(:,2)+C1C2(:,2)*R*cos(beta)*inv_distC1C2+C1C2(:,1)*R*sin(beta)*inv_distC1C2];  %Y_T1

T2=[C2(:,1)-C1C2(:,1)*R*cos(beta)*inv_distC1C2+C1C2(:,2)*R*sin(beta)*inv_distC1C2, ...  %X_T2
    C2(:,2)-C1C2(:,2)*R*cos(beta)*inv_distC1C2-C1C2(:,1)*R*sin(beta)*inv_distC1C2];  %Y_T2

C1q1=[q1.XPos,q1.YPos]-C1;
C1T1=T1-C1;
C2q2=[q2.XPos,q2.YPos]-C2;
C2T2=T2-C2;

% kat skierowany w poz 1 (q1) na okregu C1
C1_angle1=atan2_0to2pi( C1q1(:,2), C1q1(:,1));
% kat skierowany w poz 2 (T1) na okregu C1
C1_angle2=atan2_0to2pi( C1T1(:,2), C1T1(:,1));


% kat skierowany w poz 1 (T2) na okregu C2
C2_angle1=atan2_0to2pi( C2T2(:,2), C2T2(:,1));
% kat skierowany w poz 2 (q2) na okregu C2
C2_angle2=atan2_0to2pi( C2q2(:,2), C2q2(:,1));

%laczny kat obrotu na C1 (obrot w prawo)
C1_alfa=mod(C1_angle1-C1_angle2+2*pi,2*pi);
%laczny kat obrotu na C2 (obrot w lewo
C2_alfa=mod(C2_angle2-C2_angle1+2*pi,2*pi);

distance = norm(T2-T1)+R*(C1_alfa+C2_alfa);

%%wyswietlanie sciezki
figure(1);hold on;

drawArc(C1,C1_angle2,C1_angle1,R); %luk na okregu C1
drawArc(C2,C2_angle1,C2_angle2,R); %luk na okregu C2
drawVec(T1,T2);%prosta T1->T2 laczaca okregi C1 i C2



end

