function [X] = my_fft(x)
% Returns discrete Fourier transform of x
% If x is a matrix, treats each row as a vector to be transformed
% Wrapper function for fft_iterative
    X = fft_iterative(x,-1);
end