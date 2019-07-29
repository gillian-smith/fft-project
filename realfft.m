function [X] = realfft(x)
% Computes the DFT of a real-valued vector whose length must be a power of 2
% Also works on matrices where each row is a vector to be transformed
    
    [numrows N] = size(x);
    if (N < 2 || bitand(N, N-1))
        error('Vector must have length a power of 2');
    end
    
    y = zeros(numrows, N/2);
    for j = 0:N/2-1
        y(:,j+1) = x(:,2*j+1) + 1i*x(:,2*j+2);
    end
    
    Y = my_fft(y);
    Y = [Y, Y(:,1)]; 
    Yrev = conj(fliplr(Y));
    
    W = arrayfun(@exp, -(0:N/2)*2*pi*1i/N);
    W = repmat(W, numrows, 1);
    
    X = 0.5.*(Y + Yrev) - 0.5.*1i.*(Y-Yrev).*W;
    X = [X, conj(fliplr(X(:,2:N/2)))]; % restore negative frequencies
    
end