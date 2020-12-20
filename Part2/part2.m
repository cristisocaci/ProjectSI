%---------------------------------------------------------%
%                                                         %
%                       Main method                       %
%                                                         %
%---------------------------------------------------------%

tic
clear
close all

load("iddata-18.mat")

% Estimating the initial value of our model using regression, in order to
% take a non zero initial condition
regr=[ones(length(id.y),1), id.u, id.u.^2];
th=regr\id.y;
yvalInit=[1, val.u(1), val.u(1)^2]*th;  %for the simulation purposes
yidInit=[1, id.u(1), id.u(1)^2]*th;

nmax=4;
mmax=7;

% Initialize mse matrices
mse_pred_id=NaN(nmax,mmax); mse_pred_val=NaN(nmax,mmax);
mse_sim_id=NaN(nmax,mmax); mse_sim_val=NaN(nmax,mmax);


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
        
    mse_pred_id(n,m)=immse(ypred_id,id.y);
    mse_pred_val(n,m)=immse(ypred_val,val.y);
    mse_sim_id(n,m)=immse(ysim_id,id.y);
    mse_sim_val(n,m)=immse(ysim_val,val.y);
  end
end

% Compute the Euclidian norm between prediction and simulation in order to
% find the best model for both prediction and simulation

% Id
mseId = sqrt(mse_pred_id.^2 + mse_sim_id.^2);
mseminId=min(mseId,[],'all');
[nId,mId]=bestmse(mseId);

% Val
mseVal = sqrt(mse_pred_val.^2 + mse_sim_val.^2);
mseminVal=min(mseVal,[],'all');
[nVal,mVal]=bestmse(mseVal);


% Best identification model
na=nId; nb=nId; nk=1;
m=mId;
pow=generatePowers(m, na+nb);
theta = train(id.y,id.u, [na, nb, nk], pow);

ypred_id = predict(theta, id.y, id.u, [na, nb, nk], pow, yidInit);
ypred_id=iddata(ypred_id, id.u, id.Ts); % Save as iddata to compare

ysim_id = simulate(theta, id.u, [na, nb, nk], pow, yidInit);
ysim_id=iddata(ysim_id', id.u, id.Ts); % Save as iddata to compare

% Compare id
figure
compare(id, ypred_id, ysim_id); title("Identification results");

% Best validation model
na=nVal; nb=nVal; nk=1;
m=mVal;
pow=generatePowers(m, na+nb);
theta = train(id.y,id.u, [na, nb, nk], pow);

ypred_val = predict(theta, val.y, val.u, [na, nb, nk], pow, yvalInit);
ypred_val=iddata(ypred_val, val.u, val.Ts);

ysim_val = simulate(theta, val.u, [na, nb, nk], pow, yvalInit);
ysim_val=iddata(ysim_val', val.u, val.Ts);

% Compare val
figure
compare(val, ypred_val, ysim_val); title("Validation results");

toc
%---------------------------------------------------------%
%                                                         %
%               Approx Runtime: 33 seconds                %
%                      on our machine                     %
%                                                         %
%---------------------------------------------------------%