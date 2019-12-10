function [alfa] = atan2_0to2pi(Y,X)
%funkcja atan2, zwraca wartosci (0,2pi]
alfa = mod(atan2(Y,X)+2*pi,2*pi);
end

