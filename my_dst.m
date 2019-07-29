function [X] = my_dst(x)
% Computes the discrete sine transform of vector x using an FFT
% Vector x should begin with 0 and have length a power of 2

    N = size(x,2);
    
    if (N < 2 || bitand(N, N-1)) || x(1) ~= 0
        error('Vector must have length a power of 2 and begin with 0');
    end
    
    x = x(2:N);
     
    xrev = fliplr(x);
    w = arrayfun(@sin, (1:N-1).*pi./N);
    y = w.*(x + xrev) + (x - xrev)./2;

    Y = realfft([0,y]);
    Y = Y(1:N/2);
    
    R = real(Y); I = imag(Y);
    
    X = zeros(1,N);
    for n = 1:N/2
        X(2*n-1) = -I(n);
        if (n == 1)
            X(2*n) = 0.5*R(1);
        else
            X(2*n) = X(2*n-2) + R(n);
        end
    end

end