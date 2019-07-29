function [x] = my_idst(X)
% Computes the inverse discrete sine transform of X
% The discrete sine transform is its own inverse up to a factor of N/2
    N = size(X,2);
    x = my_dst(X);
    x = x.*(2/N);
end