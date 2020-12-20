function [ysim] = simulate(theta, u, param, pow, initVal)
% param = [na, nb, nk]

N = length(u);
ysim = zeros(1, N);
ysim(1)=initVal;


for i = 1:N
    regrline = zeros(1, param(1)+param(2));
    for j = 1:param(1)
        if i-j<=0
            regrline(j) = -ysim(1);
        else
            regrline(j) = -ysim(i-j);
        end
    end
    for j = param(3):param(2)+param(3)-1
        
        if i-j <= 0
            regrline(param(1)+j+1-param(3)) = u(1);
        else
            regrline(param(1)+j+1-param(3)) = u(i-j);
        end
    end
    regrline = regressor(regrline, pow);
    ysim(i) = regrline*theta;
end
end