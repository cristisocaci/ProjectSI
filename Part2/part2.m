clear
close all
load("iddata-18.mat")
% plot(id); title("Identification data")
% figure, plot(val); title("Validation data")
nmax=4;
mmax=7;
mse_pred_id=NaN(nmax,mmax);
mse_pred_val=NaN(nmax,mmax);
mse_sim_id=NaN(nmax,mmax);
mse_sim_val=NaN(nmax,mmax);
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
    
    start=50;
    
    mse_pred_id(n,m)=immse(ypred_id(start:end),id.y(start:end));
    mse_pred_val(n,m)=immse(ypred_val(start:end),val.y(start:end));
    mse_sim_id(n,m)=immse(ysim_id(start:end),id.y(start:end));
    mse_sim_val(n,m)=immse(ysim_val(start:end),val.y(start:end));
  end
end
[n_pred_id,m_pred_id]=bestmse(mse_pred_id);
[n_pred_val,m_pred_val]=bestmse(mse_pred_val);
[n_sim_id,m_sim_id]=bestmse(mse_sim_id);
[n_sim_val,m_sim_val]=bestmse(mse_sim_val);

na=n_pred_id; nb=n_pred_id; nk=1;
m=m_pred_id;

pow=generatePowers(m, na+nb);
theta = train(id.y,id.u, [na, nb, nk], pow);

ypred_id = predict(theta, id.y, id.u, [na, nb, nk], pow);

figure
plot(ypred_id(start:end), 'r'), hold on
plot(id.y(start:end), 'b'), legend("Prediction data", "Identification data")

na=n_pred_val; nb=n_pred_val; nk=1;
m=m_pred_val;

pow=generatePowers(m, na+nb);
theta = train(id.y,id.u, [na, nb, nk], pow);

ypred_id = predict(theta, val.y, val.u, [na, nb, nk], pow);

figure
plot(ypred_val(start:end), 'r'), hold on
plot(val.y(start:end), 'b'), legend("Prediction data", "Validation data")

na=n_sim_id; nb=n_sim_id; nk=1;
m=m_sim_id;

pow=generatePowers(m, na+nb);
theta = train(id.y,id.u, [na, nb, nk], pow);

ysim_id = simulate(theta, id.u, [na, nb, nk], pow);

figure
plot(ysim_id(start:end), 'r'), hold on
plot(id.y(start:end), 'b'), legend("Simulation data", "Identification data")

na=n_sim_val; nb=n_sim_val; nk=1;
m=m_sim_val;

pow=generatePowers(m, na+nb);
theta = train(id.y,id.u, [na, nb, nk], pow);

ysim_val = simulate(theta, val.u, [na, nb, nk], pow);

figure
plot(ysim_val(start:end), 'r'), hold on
plot(val.y(start:end), 'b'), legend("Simulation data", "Validation data")



