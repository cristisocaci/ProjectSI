function [regr] = regressor(d,m)

    if m == 1
       regr = deg(d,1);
    else
       regr = [regressor(d,m-1) deg(d,m)];
    end
end
