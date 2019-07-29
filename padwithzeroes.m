function [X] = padwithzeroes(x,N)
% Pads matrix x with zeroes to the right so that it has N columns

    [m n] = size(x);
    % If unspecified, take N to be the next power of 2 after n
    if nargin < 2
        N = 2^nextpow2(n);
    end
    X = [x, zeros(m, N-n)];
    
end