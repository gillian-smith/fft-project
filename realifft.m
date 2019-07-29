function [x] = realifft(X)
% Computes the inverse DFT of a vector whose inverse DFT is known to be real and whose length must be a power of 2
% Also works on matrices where each row is a vector to be transformed

    [numrows N] = size(X);
    if (N < 2 || bitand(N, N-1))
        error('Vector must have length a power of 2');
    end
    
    Xrev = X(:,(N/2+1):N); 
    X = X(:,1:N/2);
    
    W = arrayfun(@exp, (0:N/2-1)*2*pi*1i/N);
    W = repmat(W, numrows, 1);
    
    Y = 0.5.*(X + Xrev) + 0.5.*1i.*(X - Xrev).*W;
    
    y = my_ifft(Y);
    yo = real(y); ye = imag(y);
    
    x = zeros(numrows, N);
    for j = 1:N/2
        x(:,2*j-1) = yo(:,j);
        x(:,2*j) = ye(:,j);
    end
    
    % Not sure why this step is necessary or why it works
    if numrows >= N
        x = x .* numrows*2/N;
    end
    
end