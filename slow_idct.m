function [x] = slow_idct(X)
% Computes the inverse discrete cosine transform (DCT-III) of vector X directly from the definition
% Also works on matrices where each row is a vector to be transformed
    
    [numrows N] = size(X);
    x = zeros(numrows,N);
    
    for k = 1:N
        x(:,k) = 0.5*X(:,1);
        for j = 1:N-1
            x(:,k) = x(:,k) + X(:,j+1).*cos(pi*j*(k-1/2)/N);            
        end
    end
    
    x = x.*(2/N);
    
end