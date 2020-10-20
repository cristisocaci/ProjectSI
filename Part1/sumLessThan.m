function [sum] = sumLessThan(nb)
    % Returns the sum of the positive integers lower than a number
    % (including it)
    sum = 0;
    for i = 1:nb
        sum = sum + i;
    end
    
end

