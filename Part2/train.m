function [theta] = train(y,u, param)
    % param = [na, nb, nk, m]
    
    d = [-arxform(y', param(1), 1), arxform(u', param(2), param(3))];
    pd = regressor(d,param(4), false); 
    theta = pd\y;

end