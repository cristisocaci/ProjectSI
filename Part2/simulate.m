function [ysim] = simulate(theta, u, param)
    % param = [na, nb, nk, m]
    
    pow = generatePowers(param(4),param(1)+param(2));
    N = length(u);
    ysim = zeros(1, N);
    for i = 1:N
        regrline = zeros(1, param(1)+param(2));
        for j = 1:param(1)
            if i-j>0
                regrline(j) = -ysim(i-j);
            end
        end
        for j = param(3):param(2)+param(3)-1
            if i-j > 0
                regrline(param(1)+j+1-param(3)) = u(i-j);
            end
        end
        regrline = regressor(regrline, param(4), pow);
        ysim(i) = regrline*theta;
    end

end