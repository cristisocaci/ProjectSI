function [theta] = train(y,u, param, pow)
    % param = [na, nb, nk]
    d = [-arxform(y', param(1), 1, y(1)), arxform(u', param(2), param(3), u(1))];
    pd = regressor(d, pow); 
    theta = pd\y;

end