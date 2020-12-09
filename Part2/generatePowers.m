function [pow] = generatePowers(n, k)

    S = uint8(0:n);
    S = repmat({S},1,k);
    [Q{1:k}] = ndgrid(S{:});
    Q = reshape(cat(k,Q{:}),[],k);
    
    pow = uint8(zeros(length(Q), k));
    j = 1;
    for i = 1:length(Q)
        s = sum(Q(i, :));
        if 0 < s && s <= n
            pow(j,:) = Q(i,:);
            j = j+1;
        end
    end
    pow = pow(1:j-1, :);

end

