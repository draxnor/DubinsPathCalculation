function [handle] = drawVec(T1,T2)
handle=plot([T1(:,1),T2(:,1)],[T1(:,2),T2(:,2)],'-k','LineWidth',5);
end
