function [n,m]=bestmse(mse)
[n,m]=find(mse<=min(mse,[],'all'));
end