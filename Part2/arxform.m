function [out] = arxform(in, deg, nk, initVal)
% out = [in(k-nk), ... , in(k-nk-deg+1)], k = 1:N
% where the index is <= 0 we put initVal instead of 0 => in this way we
% immplement the non zero intitial conditions

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

