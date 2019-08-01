function [X] = my_ifft2(x)
% Computes the 2-dimensional inverse discrete Fourier transform of matrix x
    X = my_ifft(my_ifft(x).').';
end