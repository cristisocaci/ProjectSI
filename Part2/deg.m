function [out] = deg(d,m)
    
    l = length(d(1,:));
    pow = py.starsandbars.generate(int32(m),int32(l));
    cases = factorial(l+m-1)/factorial(m)/factorial(l-1);
    out = ones(length(d(:,1)),cases);
    for i = 1:cases
        for j = 1:l
            out(:, i) = out(:,i).*d(:, j).^double(pow{i}{j});
        end
    end
    

end

