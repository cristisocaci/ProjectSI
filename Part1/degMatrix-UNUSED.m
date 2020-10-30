function [out] = degMatrix(X1,X2,deg)
    % In order to generate the required terms for the specified degree
    % We create an auxiliary matrix. For example, for degree 3 we create
    % aux = [x1 x1 x1 x2 x2 x2] and first we multiply the 3 x1's, 
    % than with 2 x1's and one, than one x1 and 2 x2's, than 3 x2's
    
    out = ones(length(X1), deg+1);
    aux = zeros(length(X1), (deg)*2);
    for i = 1:deg
        aux(:,i)=X1;
        aux(:,end-i+1)=X2;
    end
    
    stop = deg-1;
    for i = 1:deg+1
        stop = stop+1;
        for j = i:stop
            out(:,i) = out(:,i) .* aux(:,j);
        end   
    end
    
end
