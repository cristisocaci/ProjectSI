function [ypred] = predict(theta, y, u, param, pow)
    % param = [na, nb, nk]
    
    dval = [-arxform(y', param(1), 1), arxform(u', param(2), param(3))];
    pdval = regressor(dval, pow);
    ypred = pdval*theta;
    
end