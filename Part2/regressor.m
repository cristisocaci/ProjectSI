function [regr] = regressor(d,m)

    if m == 0
       regr = deg(d,0);
    else
       regr = [regressor(d,m-1) deg(d,m)];
    end
end
