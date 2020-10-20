load('proj_fit_18.mat');
X1 = id.X{1};
X2 = id.X{2};
Y = id.Y;
surf(id.X{1}, id.X{2}, id.Y)
xlabel("x1"); ylabel("x2")
x1i = [];

for i=1:length(X1)
    x1i =[x1i ones(1,length(X2)) * X1(i)];
end
x2i = [];
for i = 1:length(X2)
    x2i = [x2i X2];
end

Xflat = [ x1i', x2i'];

Yflat = reshape(Y, length(Y)^2, 1);

[Xflat, Yflat]