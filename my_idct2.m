function [x] = my_idct2(X)
% Computes the 2-dimensional inverse discrete cosine transform (DCT-III) of matrix x
    x = my_idct(my_idct(X).').';
end