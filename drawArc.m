function [Circle_XY] = drawArc(center,angle1,angle2,R)
%center         - wspolrzedne centrum okregu
%angle1, angle2 - katy skierowane poczatku i konca luku
%R              - promien okregu
%Funkcja rysuje luk o centrum w zadanym punkcie i zadanym kacie poczatkowym
%i koncowym luku. 
%Bazowo rysuje dla kata dodatniego, jesli rysowanie dla kata ujemnego,
%nalezy podac argumenty angle1,angle2 odwrotnie.

% Funkcja wyznaczaj¹ca punkty
circleCalc = @(xCenter,yCenter,R,alfa)  [xCenter+R*cos(alfa); yCenter+R*sin(alfa)];
% zabezpieczenie na wypadek angle2 < angle1, aby zachowac kierunek ruchu
arc_angle = mod(angle2-angle1+2*pi,2*pi);
N = 100;    % Liczba punktow
Circle_XY = circleCalc(center(:,1),center(:,2),R,linspace(angle1, angle1+arc_angle, N));
plot(Circle_XY(1,:), Circle_XY(2,:), '-k', 'LineWidth', 5); hold on;
end

