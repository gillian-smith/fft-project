function [X] = my_dct2(x)
% Computes the 2-dimensional discrete cosine transform (DCT-II) of matrix x
    X = my_dct(my_dct(x).').';
end