function [regr] = regressor(d,m, pow)

    l = length(d(1,:));
    
    if( pow == false )
        pow = generatePowers(m,l);
    end
    cases = length(pow);
    regr = ones(length(d(:,1)),cases);
    
    for i = 1:cases % To investigate parfor
        regr(:, i) = prod(d.^double(pow(i,:)),2);
    end

end
