load('proj_fit_18.mat');

% Flatten the data
Xflat = flatten(id.X{1},id.X{2}); 
Yflat = reshape(id.Y, length(id.Y)^2, 1);
Xflatval = flatten(val.X{1}, val.X{2});
Yflatval = reshape(val.Y, length(val.Y)^2, 1);

maxdegree = 35;
mseid = zeros(1, maxdegree);
mseval = zeros(1, maxdegree);
for m = 1:maxdegree
    % Identification
    regr = regressor(Xflat(:,1),Xflat(:,2),m); % Find the regressor 
    theta = regr\Yflat; % Use linear regression to find the coefficients
    yhatid = regr*theta; % Predict the output of the identification data using the above computed coefficeitns
    mseid(m) = immse(yhatid, Yflat); % Compute the mse
    
    % Validation
    regr = regressor(Xflatval(:,1),Xflatval(:,2), m); % Put the validation data in the required form in order to calculate the prediction
    yhatflat = regr*theta; % Calculate the prediction 
    yhat = reshape(yhatflat, length(val.X{2}), length(val.X{2})); % Reshape the data back to amatrix form
    if m==10 % chosen from the MSE vs degree plot
        yhatstar = yhat; % save the output associated to the best degree
    end
    mseval(m) = immse(yhat, val.Y); % calculate the mse
end

% Plots
plot(1:maxdegree, mseid),title("Identification MSE vs degree")
figure
subplot(211), plot(1:maxdegree, mseval),title("Validation MSE vs degree")
subplot(212), plot(6:22, mseval(6:22)), title("Zoom in")
% from plot => MSE min is for m = 10

msestar = min(mseval);
figure
surf(val.X{1},val.X{2}, yhatstar), title("Predicted and real data, MSE="+msestar)
hold on
surf(val.X{1}, val.X{2}, val.Y, 'FaceAlpha',0.5)
xlabel("X1"); ylabel("X2"); zlabel("Y")