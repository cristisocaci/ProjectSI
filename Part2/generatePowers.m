function [pow] = generatePowers(n, k)
% Generates all the combinations with repetition then discards those whose
% sum exceed n; this combinations are used as powers when computing the
% regressor

    S = uint8(0:n);
    S = repmat({S},1,k);
    [Q{1:k}] = ndgrid(S{:});
    pow = reshape(cat(k,Q{:}),[],k);
    pow = pow(sum(pow,2)<=n,:);
    pow = pow(2:end, :);

end

