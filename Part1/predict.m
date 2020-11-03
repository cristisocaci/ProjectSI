function [yhat,mse] = predict(x,m,theta,y)
% Computes a predicted output, yhat, using the coefficients, theta, of a
% model of degree m calculated by the train function and also finds the mse 

regr = regressor(x(:,1),x(:,2),m); % Compute the regressor
yhat = regr*theta; % Predict the output of the identification data using the computed coefficients
mse = immse(yhat, y); % Compute the mse

end

