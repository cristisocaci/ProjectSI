clear
n = 3;k=2;

S = uint8(0:n);
S = repmat({S},1,k);
[Q{1:k}] = ndgrid(S{:});
catt = cat(k,Q{:});
pow = reshape(catt,[],k);