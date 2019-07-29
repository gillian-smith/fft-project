function [X] = slow_dft(x, isign)
% Returns the discrete Fourier transform X of a row vector x 
% Builds a matrix of roots of unity and performs one matrix multiplication at the end
    
    if nargin < 2
        isign = -1;
    end
    
    N = length(x);
    theta = -isign*2*pi*1i/N;
    W = ones(N,N);
    for i = 2:N
        for j = 2:i
            W(i,j) = exp(theta*((i-1)*(j-1)));
            W(j,i) = W(i,j);
        end
    end
    X = (W*x')';
    
    if isign == 1
        X = X ./ N;
    end 
    
end