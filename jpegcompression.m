close all;

% Load grayscale image
filename = 'bee.png';
img = imread(filename);

% Load quantization matrix
load Q.mat;

% Set quality
quality = 50;

[h w] = size(img);
% Crop image so its height and width are multiples of 8
h = 8*floor(h/8); w = 8*floor(w/8);
img = img(1:h, 1:w);

figure; subplot(2,2,1); imshow(img);
title('Original image');

% Pixel values need to range from -128 to 127
new_img = double(img) - 128;

% For each 8x8 block, take the 2D discrete cosine transform
for i = 1:h/8
    for j = 1:w/8
        new_img(8*(i-1)+1:8*i,8*(j-1)+1:8*j) = my_dct2(new_img(8*(i-1)+1:8*i,8*(j-1)+1:8*j));
    end
end

subplot(2,2,2); imshow(new_img);
title('DCT of each 8x8 block');

% Adjust Q for quality
if quality > 50
    Q = round((100-quality).*Q./50);
elseif quality < 50
    Q = round(50.*Q./quality);
end
Q(Q > 255) = 255;

Q = repmat(Q, h/8, w/8);

% Divide elementwise by Q and round
new_img = round(new_img ./ Q);

% Find the percentage of zeroes
percentage_zeros = round(100*(1 - nnz(new_img)/numel(new_img)));

subplot(2,2,3); imshow(new_img); 
title(['Quantized image', ' - ', num2str(percentage_zeros), '% zeroes']);

% Multiply elementwise by Q
new_img = new_img .* Q;

% For each 8x8 block, take the 2D inverse DCT
for i = 1:h/8
    for j = 1:w/8
        new_img(8*(i-1)+1:8*i,8*(j-1)+1:8*j) = my_idct2(new_img(8*(i-1)+1:8*i,8*(j-1)+1:8*j));
    end
end

% Round and add 128
new_img = uint8(round(new_img) + 128);

subplot(2,2,4); imshow(new_img);
title('Decompressed image');
