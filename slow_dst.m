function [X] = slow_dst(x)
% Computes the discrete sine transform of vector x directly from the definition

    if x(1) ~= 0
        error('Vector must begin with 0');
    end 
    
    N = length(x);
    
    theta = pi/N;
    W = zeros(N,N);
    for i = 2:N
        for j = 2:i
            W(i,j) = sin(theta*((i-1)*(j-1)));
            W(j,i) = W(i,j);
        end
    end
    X = (W*x')';

end