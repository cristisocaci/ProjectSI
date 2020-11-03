function [xflat] = flatten(x1, x2)
% Creates a matrix that contains all the combinations between x1 and x2
% values

x1repeat = repmat(x1,length(x2),1);
x1repeat = reshape(x1repeat,length(x1)*length(x2),1);
xflat = [x1repeat, repmat(x2', length(x1),1)];
end

