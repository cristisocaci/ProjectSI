load('proj_fit_18.mat');
id.X1 = id.X{1};
id.X2 = id.X{2};
val.X1 = val.X{1};
val.X2 = val.X{2};

maxdegree = 20;

mse = zeros(1, maxdegree);

for m = 1:maxdegree
    % Identification
    Xflat = flatten(id.X1,id.X2);
    Yflat = reshape(id.Y, length(id.Y)^2, 1);
    regr = regressor(Xflat,m);
    theta = regr\Yflat;
    
    % Validation
    Xflatval = flatten(val.X1, val.X2);
    Yflatval = reshape(val.Y, length(val.Y)^2, 1);
    regr = regressor(Xflatval, m);
    yhatflat = regr*theta;
    yhat = reshape(yhatflat, length(val.X2), length(val.X2));
    if m==10
        yhatstar = yhat;
    end
    mse(m) = 1/length(Yflatval) * sum( (yhatflat - Yflatval).^2 );
end
subplot(211), plot(1:maxdegree, mse),title("MSE vs degree")
subplot(212), plot(6:maxdegree, mse(6:end)), title("Zoom in")
% from plot => MSE min is for m = 10

figure
surf(val.X1,val.X2, yhatstar)
hold on
surf(val.X1, val.X2, val.Y, 'FaceAlpha',0.5),  xlabel("X1"); ylabel("X2"); zlabel("Y")