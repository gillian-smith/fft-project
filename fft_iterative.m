function [X] = fft_iterative(x, isign)
% Returns the discrete Fourier transform (if isign = -1) or inverse discrete Fourier transform (if isign = 1) of vector x
% Also works on matrices where each row is a vector to be transformed
% If the number of columns is not a power of 2 then x will be padded with zeroes
% User should use wrapper functions my_fft and my_ifft

    % Default is forward DFT
    % This check should not be necessary if wrapper functions are used
    if nargin < 2
        isign = -1;
    end
    
    % This check should not be necessary if wrapper functions are used
    if (isign ~= 1 && isign ~= -1)
        error(['Unexpected value', ' ', num2str(isign), ' for parameter isign']);
    end
    
    N = size(x,2); % length of a row i.e. number of columns
    if (N < 2 || bitand(N, N-1))
        sprintf('Vector must have length a power of 2. Padding with zeroes...');
        N = 2^nextpow2(N);
        x = padwithzeroes(x, N);
    end

    % Bit-reversal permutation
    order = bitreverseperm((0:N-1)') + 1;
    X = x(:,order);

    % Create table of roots of unity
    % We only need N/2 of them because we can multiply by -1 (i.e. subtract) to get the missing ones
    theta = 2*pi*isign*1i/N;
    w_table = arrayfun(@exp, theta*(0:N/2-1)); 

    curr_N = 2; % Size of FFTs to be performed at this stage
    while (curr_N <= N) % Repeat until we get the FFT of the whole dataset
        half_curr_N = curr_N / 2;
        tablestep = N / curr_N; % For stepping through roots of unity
        for i = 1:curr_N:N % For each individual sub-transform
            k = 1; % Start with first root of unity e^0 = 1
            for j = i:(i + half_curr_N - 1) % For each pair of components in this sub-transform
                temp = X(:, j + half_curr_N).*w_table(k);
                X(:,j + half_curr_N) = X(:,j) - temp; % Subtracting for missing root of unity
                X(:,j) = X(:,j) + temp;
                k = k + tablestep; % Go to next root of unity and next pair of components
            end
        end
        curr_N = curr_N*2; % Double the size of the sub-transform for the next stage
    end

end