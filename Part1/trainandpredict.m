function [yhat,mse, theta] = trainandpredict(x, y, m)
% Used for efficency when training and also calculating a prediction on the
% same dataset because the regressor is not calculated twice

    regr = regressor(x(:,1),x(:,2),m); % Find the regressor 
    theta = regr\y; % Use linear regression to find the coefficients
    yhat = regr*theta; % Predict the output of the identification data using the computed coefficients
    mse = immse(yhat, y); % Compute the mse
end

