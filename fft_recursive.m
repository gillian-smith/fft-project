function [X] = fft_recursive(x, isign)
% Recursive FFT algorithm  
% Returns the same result as the iterative algorithm, but is much slower
    
    % Default to forward DFT
    if nargin < 2
        isign = -1;
    end
    
    if (isign ~= 1 && isign ~= -1)
        error(['Unexpected value', ' ', num2str(isign), ' for parameter isign']);
    end
    
    N = length(x);
    if (N < 2 || bitand(N, N-1))
        sprintf('Vector must have length a power of 2. Padding with zeroes...');
        N = 2^nextpow2(N);
        x = padwithzeroes(x, N);
    end

    
    X = zeros(1,N);
    if (N == 1)
        X(1) = x(1);
    else
        theta = isign*2*pi*1i/N;
        w_table = arrayfun(@exp, theta*(0:N/2-1));
        X(1:N/2) = fft_recursive(x(1:2:N), isign);
        X(N/2+1:N) = fft_recursive(x(2:2:N), isign);
        for k = 1:N/2
            t = X(k);
            X(k) = t + w_table(k)*X(k+N/2);
            X(k+N/2) = t - w_table(k)*X(k+N/2);
        end
    end
    
end