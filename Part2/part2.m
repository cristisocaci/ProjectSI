clear
close all
load("iddata-18.mat")
% plot(id); title("Identification data")
% figure, plot(val); title("Validation data")

% na = nb = n
% for simulation
% n = 1 => mmax = 7;
% n = 2 => mmax = 5;
% n = 3 => mmax = 3;
% n = 4 => mmax = 2;

n = 4;
na = n; nb =n; nk = 1;
m = 2;
pow=generatePowers(m, na+nb);
theta = train(id.y,id.u, [na, nb, nk], pow);

% prediction
ypred = predict(theta, val.y, val.u, [na, nb, nk], pow);

figure
plot(ypred, 'r'), hold on
plot(val.y, 'b'), legend("Prediction data", "Validation data")

% simulation
ysim = simulate(theta, val.u, [na, nb, nk], pow)';

figure
plot(ysim, 'r'), hold on
plot(val.y, 'b'), legend("Simulation data", "Validation data")


