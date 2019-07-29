function [X] = my_ifft(x)
% Returns inverse discrete Fourier transform of x
% Wrapper function for fft_iterative
    X = fft_iterative(x,1);
    X = X ./ length(X);
end