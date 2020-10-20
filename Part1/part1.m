load('proj_fit_18.mat');
id.X1 = id.X{1};
id.X2 = id.X{2};
val.X1 = val.X{1};
val.X2 = val.X{2};


m = 4;

Xflat = flatten(id.X1,id.X2);
Yflat = reshape(id.Y, length(id.Y)^2, 1);

regr = regressor(Xflat,m);
theta = regr\Yflat;

Xflatval = flatten(val.X1, val.X2);
regr = regressor(Xflatval, m);
yhatflat = regr*theta;
yhat = reshape(yhatflat, length(val.X2), length(val.X2));

surf(val.X1,val.X2, yhat)
hold on
surf(val.X1, val.X2, val.Y, 'FaceAlpha',0.5),  xlabel("X1"); ylabel("X2"); zlabel("Y")