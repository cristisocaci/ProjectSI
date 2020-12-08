
clear
load("data.mat")
%plot(id); title("Identification data")
%figure, plot(val); title("Validation data")

na = 2; nb =2; nk = 1;
m = 2;

d = [-arxform(id.y', na, 1), arxform(id.u', nb, nk)];
pd = regressor(d,m); 
theta = pd\id.y;

% prediction
dval = [-arxform(val.y', na, 1), arxform(val.u', nb, nk)];
pdval = regressor(dval,m); 
ypred = pdval*theta;

figure
plot(ypred, 'r')
hold on
plot(val.y, 'b'), legend("Prediction data", "Validation data")

% simulation
N = length(val.u);
ysim = zeros(1, N);
for i = 1:N
    regrline = zeros(1, na+nb);
    for j = 1:na
        if i-j>0
            regrline(j) = -ysim(i-j);
        end
    end
    for j = 1:nb
        if i-j > 0
            regrline(na+j) = val.u(i-j);
        end
    end
    regrline = regressor(regrline, m);
    ysim(i) = regrline*theta;
end

figure
plot(ysim, 'r')
hold on
plot(val.y, 'b'), legend("Simulation data", "Validation data")

