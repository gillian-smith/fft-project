function [X] = my_dct(x)
% Computes the discrete cosine transform (DCT-II) of vector x using an FFT
% Also works on matrices where each row is a vector to be transformed
    
    [numrows N] = size(x);
    if (N < 2 || bitand(N, N-1))
        error('Vector must have length a power of 2');
    end

    xrev = fliplr(x);
    w = arrayfun(@sin, ((0:N-1)+0.5)*pi/N);
    w = repmat(w, numrows, 1);
    y = 0.5.*(x + xrev) + w.*(x - xrev);
    
    Y = realfft(y);
    R = real(Y); I = imag(Y);
    
    X = zeros(numrows,N);
    X(:,N) = 0.5*R(:,N/2+1);
    for k = N/2:-1:1
        X(:,2*k-1) = cos(pi*(k-1)/N)*R(:,k) + sin(pi*(k-1)/N)*I(:,k);
        if k ~= 1
            X(:,2*k-2) = sin(pi*(k-1)/N)*R(:,k) - cos(pi*(k-1)/N)*I(:,k) + X(:,2*k);
        end
    end

end