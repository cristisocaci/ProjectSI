tic
clear
close all
load("iddata-18.mat")

nmax=4;
mmax=7;
mse_pred_id=NaN(nmax,mmax);
mse_pred_val=NaN(nmax,mmax);
mse_sim_id=NaN(nmax,mmax);
mse_sim_val=NaN(nmax,mmax);

start=50;
stop = length(id.y);
l = start:stop;

for n=1:nmax
    na = n; nb =n; nk = 1;
    
  for m=1:mmax
    
    pow=generatePowers(m, na+nb);
    theta = train(id.y,id.u, [na, nb, nk], pow);
    
    % prediction id
    ypred_id = predict(theta, id.y, id.u, [na, nb, nk], pow);
    
    % simulation id
    ysim_id = simulate(theta, id.u, [na, nb, nk], pow)';
    
    % prediction val
    ypred_val = predict(theta, val.y, val.u, [na, nb, nk], pow);
    
    % simulation val
    ysim_val = simulate(theta, val.u, [na, nb, nk], pow)';
        
    mse_pred_id(n,m)=immse(ypred_id(l),id.y(l));
    mse_pred_val(n,m)=immse(ypred_val(l),val.y(l));
    mse_sim_id(n,m)=immse(ysim_id(l),id.y(l));
    mse_sim_val(n,m)=immse(ysim_val(l),val.y(l));
  end
end

mseId = sqrt(mse_pred_id.^2 + mse_sim_id.^2);
mseminId=min(mseId,[],'all');
[nId,mId]=bestmse(mseId);
mseVal = sqrt(mse_pred_val.^2 + mse_sim_val.^2);
mseminVal=min(mseVal,[],'all');
[nVal,mVal]=bestmse(mseVal);


% Best identification plots
na=nId; nb=nId; nk=1;
m=mId;

pow=generatePowers(m, na+nb);
theta = train(id.y,id.u, [na, nb, nk], pow);
ypred_id = predict(theta, id.y, id.u, [na, nb, nk], pow);
ysim_id = simulate(theta, id.u, [na, nb, nk], pow);

figure
plot(l,ypred_id(l), 'r'), hold on
plot(l,id.y(l), 'b'), legend("Prediction data", "Identification data")
title({'Prediction on identification data', ['MSE= ' num2str(mseminId)]});
figure
plot(l,ypred_id(l), 'r'), hold on
plot(l,id.y(l), 'b'), legend("Simulation data", "Identification data")
title({'Simulation on identification data',['MSE= ' num2str(mseminId)]});

% Best validation plots
na=nVal; nb=nVal; nk=1;
m=mVal;

pow=generatePowers(m, na+nb);
theta = train(id.y,id.u, [na, nb, nk], pow);
ypred_val = predict(theta, val.y, val.u, [na, nb, nk], pow);
ysim_val = simulate(theta, val.u, [na, nb, nk], pow);

figure
plot(l,ypred_val(l), 'r'), hold on
plot(l,val.y(l), 'b'), legend("Prediction data", "Validation data")
title({'Prediction on validation data',['MSE= ' num2str(mseminVal)]});
figure
plot(l,ysim_val(l), 'r'), hold on
plot(l,val.y(l), 'b'), legend("Simulation data", "Validation data")
title({'Simulation on validation data',['MSE= ' num2str(mseminVal)]});

toc

