function [n,m]=bestmse(mse)
% Returns the indexes of the best mes from a mse matrix

    [n,m]=find(mse<=min(mse,[],'all'));
end