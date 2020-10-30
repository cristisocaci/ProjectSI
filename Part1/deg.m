function [out] = deg(x1, x2, m)
% Returns a 2D polynomial of degree m; 
% example: degree 3 = [x1^3, x1^2*x2, x1*x2^2, x2^3]
out=zeros(length(x1),m+1);
for i = 0:m
    out(:,i+1) = x1.^(m-i) .* x2.^(i);
end
end
