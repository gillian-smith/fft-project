function [x] = my_idct(X)
% Computes the inverse discrete cosine transform (DCT-III) of vector X
% Also works on matrices where each row is a vector to be transformed

    [numrows N] = size(X);
    if (N < 2 || bitand(N, N-1))
        error('Vector must have length a power of 2');
    end
    
    R = zeros(numrows, N); I = R;
    R(:,1) = X(:,1); % I(1) = 0 already
    for k = 2:N/2
        Rk = sin(pi*(k-1)/N).*(X(:,2*k-2)-X(:,2*k)) + cos(pi*(k-1)/N).*X(:,2*k-1);
        R(:,k) = Rk;
        R(:,N-k+2) = Rk;
        Ik = - cos(pi*(k-1)/N).*(X(:,2*k-2)-X(:,2*k)) + sin(pi*(k-1)/N).*X(:,2*k-1);
        I(:,k) = Ik;
        I(:,N-k+2) = -Ik;
    end
    R(:,N/2+1) = 2*X(:,N);
    
    Y = R + 1i*I;
    y = realifft(Y);
    
    y1 = y(:,1:N/2);
    y2 = fliplr(y(:,N/2+1:N));
    w = arrayfun(@csc, ((0:N/2-1)+0.5)*pi/N);
    w = repmat(w, numrows, 1);
    alpha = 0.25.*(y1 - y2).*w;
    beta = 0.5.*(y1 + y2);
    x1 = alpha + beta;
    x2 = -alpha + beta;
    x = [x1, fliplr(x2)];

end