function [theta] = train(id, param)
    % param = [na, nb, nk, m]
    
    d = [-arxform(id.y', param(1), 1), arxform(id.u', param(2), param(3))];
    pd = regressor(d,param(4)); 
    theta = pd\id.y;

end