function [regr] = regressor(x1,x2,m)
% recursive function to find the regressor
% uses the fact that the regressor of a certain degree contains all the 
% elements of the lower degree regressor and some unique elements for that
% degree which are calculated and explained in the deg function
if m == 0
    regr = deg(x1,x2,0);
else
    regr = [regressor(x1,x2,m-1) deg(x1,x2,m)];
end
end