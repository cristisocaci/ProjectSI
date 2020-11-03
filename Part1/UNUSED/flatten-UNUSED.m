function [Xflat] = flatten(X1,X2)

len1 = length(X1);
len2 = length(X2);
x1i = zeros(1,len1*len2);
x2i = zeros(1,len1*len2);
for i=1:len1
    x1i( (i-1)*len2+1 : i*len2 )  = ones(1,length(X2)) * X1(i);
    x2i( (i-1)*len2+1 : i*len2 ) = X2;
end

Xflat = [x1i', x2i'];

end

