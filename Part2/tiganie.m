
%% tiganie ; ne mai gandim
S = 0:3;
n = 2;
s = repmat({S},1,n);
[Q{1:n}] = ndgrid(s{:});
Q = reshape(cat(n,Q{:}),[],n);