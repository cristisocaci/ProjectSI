function [regr] = regressor(Xflat,degree)
    % We observed that a certain degree of the regressor contains all the
    % terms that the lower degrees contain; Ex: degree 0 contains "1"; degree 1
    % contains degree 0 and "x1 x2"; degree 2 contains degree 0, 1 and
    % "x1^2 x2^2 x1x2"; this pattern applys for higher degrees also. In
    % order to create a regressor of a certain degree we create all the
    % terms of the smaller degrees and append them to the regressor.
    % Function degMatrix creates the terms of a certain degree 
    
    regr =[ ones(length(Xflat(:,1)),1) Xflat];
    for deg = 2:degree
        regr = [regr degMatrix(Xflat(:,1), Xflat(:,2), deg)];
    end
end

