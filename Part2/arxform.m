function [out] = arxform(in, deg, nk, initVal)
N = length(in);
out = initVal*ones(N, deg);
for i = 1:N
    for j = nk:deg+nk-1
        if i-j > 0
            out(i,j+1-nk) = in(i-j);
        end
    end
end
end

