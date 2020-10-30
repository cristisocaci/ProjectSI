load('proj_fit_18.mat');

% Flatten the data
Xflat = flatten(id.X{1},id.X{2}); 
Yflat = reshape(id.Y, length(id.Y)^2, 1);
Xflatval = flatten(val.X{1}, val.X{2});
Yflatval = reshape(val.Y, length(val.Y)^2, 1);

maxdegree = 20;
mse = zeros(1, maxdegree);
for m = 1:maxdegree
    % Identification
    regr = regressor(Xflat(:,1),Xflat(:,2),m);
    theta = regr\Yflat;
    
    % Validation
    regr = regressor(Xflatval(:,1),Xflatval(:,2), m);
    yhatflat = regr*theta;
    yhat = reshape(yhatflat, length(val.X{2}), length(val.X{2}));
    if m==10
        yhatstar = yhat;
    end
    mse(m) = immse(yhat, val.Y);
end
subplot(211), plot(1:maxdegree, mse),title("MSE vs degree")
subplot(212), plot(6:maxdegree, mse(6:end)), title("Zoom in")
% from plot => MSE min is for m = 10
msestar = min(mse);
figure
surf(val.X{1},val.X{2}, yhatstar)
hold on
surf(val.X{1}, val.X{2}, val.Y, 'FaceAlpha',0.5),  xlabel("X1"); ylabel("X2"); zlabel("Y")