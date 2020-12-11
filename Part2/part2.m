clear
load("iddata-18.mat")
% plot(id); title("Identification data")
% figure, plot(val); title("Validation data")

na = 2; nb =2; nk = 1;
m = 8;

theta = train(id.y,id.u, [na, nb, nk, m]);

% prediction
ypred = predict(theta, val.y, val.u, [na, nb, nk, m]);

figure
plot(ypred, 'r'), hold on
plot(val.y, 'b'), legend("Prediction data", "Validation data")

% simulation
ysim = simulate(theta, val.u, [na, nb, nk, m])';

figure
plot(ysim, 'r'), hold on
plot(val.y, 'b'), legend("Simulation data", "Validation data")


