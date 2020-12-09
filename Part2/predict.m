function [ypred] = predict(theta, val, param)
    % param = [na, nb, nk, m]
    
    dval = [-arxform(val.y', param(1), 1), arxform(val.u', param(2), param(3))];
    pdval = regressor(dval,param(4), false);
    ypred = pdval*theta;
    
end