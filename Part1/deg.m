function [out] = deg(x1, x2, m)
% Returns the unique elements of a certain degree regressor;
% For example: a regressor of degree 0 contains [1],
% a regressor of degree 1 contains [1, x1, x2],
% a regressor of degree 2 contains [1, x1, x2, x1^2, x1x2, x2^2], and so
% on. We can see that the unique elements of a certain degree, m, are the 
% basis elements of a 2D polynomial of degree m which can be calculated 
% using the formula: x1^(m-i)*x2^i, i=0:m

out=zeros(length(x1),m+1);
for i = 0:m
    out(:,i+1) = x1.^(m-i) .* x2.^(i);
end

end
