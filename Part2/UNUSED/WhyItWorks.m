clear
n = 4;k=4;

S = uint8(0:n);
S = repmat({S},1,k);
[Q{1:k}] = ndgrid(S{:});
% TODO optimizare
catt = cat(k,Q{:});
pow = reshape(catt,[],k);
pow = pow(sum(pow,2)<=n,:);
pow = pow(2:end, :);