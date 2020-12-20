




%---------------------------------------------------------%
%                                                         %
%               Approx Runtime: 33 seconds                %
%                      on our machine                     %
%                                                         %
%                                                         %
%---------------------------------------------------------%

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

start=1;
stop = length(id.y);
interval = start:stop;
%Estimating the initial value of our model using regression, in order to
%take a non zero initial condition for simulation

regr=[ones(length(id.y),1), id.u, id.u.^2];
th=regr\id.y;
yvalInit=[1, val.u(1), val.u(1)^2]*th;  %for the simulation purposes
yidInit=[1, id.u(1), id.u(1)^2]*th;

for n=1:nmax
    na = n; nb =n; nk = 1;
    
  for m=1:mmax
    
    pow=generatePowers(m, na+nb);
    theta = train(id.y,id.u, [na, nb, nk], pow);
    
    % prediction id
    ypred_id = predict(theta, id.y, id.u, [na, nb, nk], pow, yidInit);
    
    % simulation id
    ysim_id = simulate(theta, id.u, [na, nb, nk], pow, yidInit)';
    
    % prediction val
    ypred_val = predict(theta, val.y, val.u, [na, nb, nk], pow, yvalInit);
    
    % simulation val
    ysim_val = simulate(theta, val.u, [na, nb, nk], pow, yvalInit)';
        
    mse_pred_id(n,m)=immse(ypred_id(interval),id.y(interval));
    mse_pred_val(n,m)=immse(ypred_val(interval),val.y(interval));
    mse_sim_id(n,m)=immse(ysim_id(interval),id.y(interval));
    mse_sim_val(n,m)=immse(ysim_val(interval),val.y(interval));
  end
end

mseId = sqrt(mse_pred_id.^2 + mse_sim_id.^2);
[nId,mId]=bestmse(mseId);
mseVal = sqrt(mse_pred_val.^2 + mse_sim_val.^2);
[nVal,mVal]=bestmse(mseVal);


% Best identification plots
na=nId; nb=nId; nk=1;
m=mId;
pow=generatePowers(m, na+nb);
theta = train(id.y,id.u, [na, nb, nk], pow);
ypred_id = predict(theta, id.y, id.u, [na, nb, nk], pow, yidInit);
ysim_id = simulate(theta, id.u, [na, nb, nk], pow, yidInit);

figure
plot(interval,ypred_id(interval), 'r'), hold on
plot(interval,id.y(interval), 'b'), legend("Prediction data", "Identification data") 
figure
plot(interval,ypred_id(interval), 'r'), hold on
plot(interval,id.y(interval), 'b'), legend("Simulation data", "Identification data")

% Best validation plots
na=nVal; nb=nVal; nk=1;
m=mVal;

pow=generatePowers(m, na+nb);
theta = train(id.y,id.u, [na, nb, nk], pow);
ypred_val = predict(theta, val.y, val.u, [na, nb, nk], pow, yvalInit);
ysim_val = simulate(theta, val.u, [na, nb, nk], pow, yvalInit);

figure
plot(interval,ypred_val(interval), 'r'), hold on
plot(interval,val.y(interval), 'b'), legend("Prediction data", "Validation data")
figure
plot(interval,ysim_val(interval), 'r'), hold on
plot(interval,val.y(interval), 'b'), legend("Simulation data", "Validation data")



figure
modelSimId=iddata(ysim_id', id.u, id.Ts);
modelPredId=iddata(ypred_id, id.u, id.Ts);
compare(id, modelPredId);
figure
compare(id, modelSimId);

%Constructing the models on validation dataset and comparing them with the
%actual outputs
figure
modelSim=iddata(ysim_val', val.u, val.Ts);
modelPred=iddata(ypred_val, val.u, val.Ts);
compare(val, modelPred);
figure
compare(val, modelSim);
toc

