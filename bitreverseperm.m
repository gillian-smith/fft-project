function [permA] = bitreverseperm(A)
% Returns bit-reverse permutation of column vector A

% For example:
% bitreverseperm((0:7)') returns [0; 4; 2; 6; 1; 5; 3; 7]

    permA = bin2dec(fliplr(dec2bin(A)));
    
end

function [vec] = dec2bin(n, bits)
% Converts a decimal integer n to a binary row vector vec with least significant bit first
% If n is a column vector, returns the binary equivalent of each component

% For example:
% dec2bin(5) returns [1 0 1]
% dec2bin(5,6) returns [1 0 1 0 0 0]
% dec2bin((0:3)') returns [0 0; 1 0; 0 1; 1 1]

% If unspecified, take the number of bits to be the smallest number of bits that the biggest element of n can fit into
if nargin < 2
    bits = max(nextpow2(n+1));
end
vec = [];
for i = 1:bits
    vec = [vec, mod(n,2)];
    n = floor(n/2);
end

end

function [n] = bin2dec(vec)
% Converts a binary row vector with least significant bit first to a decimal number
% If vec is a matrix, treat each row as a binary row vector and convert each to a decimal number

% For example:
% bin2dec([0 0 1]) returns 4
% bin2dec([1 0 0; 0 1 0; 1 1 0; 0 0 1]) returns [1; 2; 3; 4]

n = zeros(size(vec,1),1);
for i = 1:size(vec,2)
    n = n + vec(:,i).*2^(i-1);
end

end