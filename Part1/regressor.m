function [regr] = regressor(x1,x2,m)
% recursive function to find the regressor
if m == 0
    regr = deg(x1,x2,0);
else
    regr = [regressor(x1,x2,m-1) deg(x1,x2,m)];
end
end

