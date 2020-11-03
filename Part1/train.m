function [theta] = train(x,y, m)
% Finds the coefficients theta for a model of degree m

    regr = regressor(x(:,1),x(:,2),m); % Find the regressor 
    theta = regr\y; % Use linear regression to find the coefficients
end

