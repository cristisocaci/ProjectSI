load('proj_fit_18.mat');

id.X1 = id.X{1};
id.X2 = id.X{2};
% surf(id.X1, id.X2, id.Y), xlabel("x1"); ylabel("x2")

Xflat = flatten(id.X1,id.X2);
Yflat = reshape(id.Y, length(id.Y)^2, 1);

regr = [ones(length(id.X2)^2, 1), Xflat];

theta = regr\Yflat;

val.X1 = val.X{1};
val.X2 = val.X{2};

Xflatval = flatten(val.X1, val.X2);
regr = [ones(length(val.X2)^2, 1), Xflatval];
yhatflat = regr*theta;
yhat = reshape(yhatflat, length(val.X2), length(val.X2));

surf(val.X1,val.X2, yhat)
hold on
surf(val.X1, val.X2, val.Y, 'FaceAlpha',0.5)