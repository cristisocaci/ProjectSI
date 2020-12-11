function [ypred] = predict(theta, y, u, param)
    % param = [na, nb, nk, m]
    
    dval = [-arxform(y', param(1), 1), arxform(u', param(2), param(3))];
    pdval = regressor(dval,param(4), false);
    ypred = pdval*theta;
    
end