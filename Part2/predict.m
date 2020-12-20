function [ypred] = predict(theta, y, u, param, pow, initVal)
    % param = [na, nb, nk]
    
    dval = [-arxform(y', param(1), 1, initVal), arxform(u', param(2), param(3), u(1))];
    pdval = regressor(dval, pow);
    ypred = pdval*theta;
end