function [regr] = regressor(d, pow)
tic
    cases = length(pow);
    regr = ones(length(d(:,1)),cases);
    
    for i = 1:cases % To investigate parfor
        regr(:, i) = prod(d.^double(pow(i,:)),2);
    end
toc
end
