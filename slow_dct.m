function [X] = slow_dct(x)
% Computes the discrete cosine transform (DCT-II) of vector x directly from the definition
    
    N = size(x,2);

    theta = pi/N;
    W = ones(N,N);
    for i = 1:N
        for j = 2:N
            W(i,j) = cos(theta*((i-0.5)*(j-1)));
        end
    end
    X = x*W;
    
end