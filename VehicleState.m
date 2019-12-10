classdef VehicleState
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        XPos {mustBeNumeric}
        YPos {mustBeNumeric}
        theta {mustBeNumeric} % orientacja
        R = 0.5 % {mustBeNumeric} % promien skretu
        K = 0.2; %{mustBeNumeric} %wydluzenie wektora do rysowania, aby uwidoczniæ
    end
    
    methods
        % Konstruktor
        function obj = VehicleState(XPos,YPos,theta)
            obj.XPos = XPos;
            obj.YPos = YPos;
            if 0 <= theta <= 2*pi
                obj.theta = theta;
            else
                ME = MException('Niepoprawna wartosc theta', 'Przekroczenie zakresu theta');
                throw(ME);
            end
        end
        
        % Wyswietlenie stanu (punkt z wektorem orientacji)
        function [obj,XVec,YVec] = StatePlot(obj) 
            k=0.01; % krokWektora
            XVec=obj.XPos+[0:k:obj.K]*cos(obj.theta);
            YVec=obj.YPos+[0:k:obj.K]*sin(obj.theta);
            scatter(obj.XPos,obj.YPos,'*r','LineWidth',5)
            plot(XVec,YVec,'-r','LineWidth',3)
        end
        
        function [LeftCircleCenter] = LeftCircleCalc(obj)
            LeftCircleCenter=[obj.XPos - obj.R*sin(obj.theta),obj.YPos + obj.R*cos(obj.theta)];
        end
        
        function [LeftCircleCenter] = LeftCirclePlot(obj)
            LeftCircleCenter=[obj.XPos - obj.R*sin(obj.theta),obj.YPos + obj.R*cos(obj.theta)];
            scatter(LeftCircleCenter(:,1),LeftCircleCenter(:,2),'filled','b');
            viscircles(LeftCircleCenter,obj.R,'Color','y');
            
        end
        function [RightCircleCenter] = RightCirclePlot(obj)
            RightCircleCenter=[obj.XPos + obj.R*sin(obj.theta),obj.YPos - obj.R*cos(obj.theta)];
            scatter(RightCircleCenter(:,1),RightCircleCenter(:,2),'filled','b');
            viscircles(RightCircleCenter,obj.R,'Color','y');
            
        end
        
        function [RightCircleCenter] = RightCircleCalc(obj)
            RightCircleCenter=[obj.XPos + obj.R*sin(obj.theta),obj.YPos - obj.R*cos(obj.theta)];
        end
    end
end

