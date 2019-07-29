function [X] = my_fft2(x)
% Computes the 2-dimensional discrete Fourier transform of matrix x
% If dimensions of x are not powers of 2, x will be padded with zeroes
    X = my_fft(my_fft(x).').';
end