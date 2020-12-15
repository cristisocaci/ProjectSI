clear
load("iddata-18.mat")
% plot(id); title("Identification data")
% figure, plot(val); title("Validation data")

na = 3; nb = 3; nk = 1;
m =6;
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


