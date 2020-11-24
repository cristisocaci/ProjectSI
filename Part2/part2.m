
clear
load("data.mat")
%plot(id); title("Identification data")
%figure, plot(val); title("Validation data")

na = 2; nb =2; nk = 1;
m = 3;

d = [-arxform(id.y', na, 1), arxform(id.u', nb, nk)];
pd = regressor(d,m); 
pd = pd(:, 2:end);
theta = pd\id.y;

dval = [-arxform(val.y', na, 1), arxform(val.u', nb, nk)];
pdval = regressor(dval,m); 
pdval = pdval(:, 2:end);
ypred = pdval*theta;

figure
plot(ypred, 'r')
hold on
plot(val.y, 'b'), legend("Prediction data", "Validation data")