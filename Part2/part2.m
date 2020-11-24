
clear
load("data.mat")
%plot(id); title("Identification data")
%figure, plot(val); title("Validation data")

na = 2; nb = 2; nk = 1;
m = 1;

d = [-arxform(id.y', na, 1), arxform(id.u', nb, nk)];

pd = regressor(d,m); 
pd = pd(:, 2:end);