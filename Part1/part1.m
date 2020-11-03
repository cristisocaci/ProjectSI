load('proj_fit_18.mat');

% Flatten the data
Xflat = flatten(id.X{1},id.X{2}); 
Yflat = reshape(id.Y, length(id.Y)^2, 1);
Xflatval = flatten(val.X{1}, val.X{2});
Yflatval = reshape(val.Y, length(val.Y)^2, 1);

maxdegree = 35;
M = 1:maxdegree;
mseid = zeros(1, maxdegree);
mseval = zeros(1, maxdegree);
for m = M
    % Identification
    [yhatid, mseid(m), theta] = trainandpredict(Xflat,Yflat,m);
  
    % Validation
    [yhatflat, mseval(m)] = predict(Xflatval,m,theta,Yflatval); 
end

% MSE Plots
plot(1:maxdegree, mseid),title("Identification MSE vs degree")
figure
subplot(211), plot(1:maxdegree, mseval),title("Validation MSE vs degree")
subplot(212), plot(6:22, mseval(6:22)), title("Zoom in")

% Find the best mse and compute the yhat for it
msestar = min(mseval);
mstar = M(mseval==msestar);
thetastar = train(Xflat, Yflat, mstar);
[yhatstar, ] = predict(Xflatval,mstar,thetastar,Yflatval);
yhatstar = reshape(yhatstar, length(val.Y), length(val.Y));

% Plot the best yhat
figure
surf(val.X{1},val.X{2}, yhatstar), title("Predicted and real data, MSE="+msestar)
hold on
surf(val.X{1}, val.X{2}, val.Y, 'FaceAlpha',0.5)
xlabel("X1"); ylabel("X2"); zlabel("Y")
