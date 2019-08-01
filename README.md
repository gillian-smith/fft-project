# fft-project
MATLAB code for a project on the Fast Fourier Transform

# Usage

## FFT functions

The function `my_fft` takes as input a row vector `f` and returns its discrete Fourier transform as a row vector `F`. If the length of `f` is a power of 2, then `F` will be the same length. If the length of `f` is not a power of 2, then `f` will be padded with zeroes so that its length is a power of 2, and `F` will be the DFT of the padded vector. The function `my_ifft` behaves similarly, but returns the inverse DFT.

```matlab
f = rand(1,4) + 1i*rand(1,4)
F = my_fft(f) % returns the discrete Fourier transform of f
my_ifft(F) % should be the same as f
```

## Real FFT functions

In the case where `f` contains real numbers only, the function `realfft` can be used instead. In the case of a vector `F` whose inverse DFT is known to be real, the function `realifft` can be used.

```matlab
f = rand(1,8)
F = realfft(f)
realifft(F) % should be the same as f
```

## Discrete sine and cosine transforms

The function `my_dst` takes as input a row vector `f` and returns its discrete sine transform. The length of `f` must be a power of 2, it must begin with `0`, and its entries should all be real numbers. The function `my_idst` returns the inverse DST.

The function `my_dct` takes as input a row vector `f`, whose components should all be real, and whose length should be a power of 2, and returns its discrete cosine transform (DCT-II). The function `my_idct` returns the DCT-III, which is the inverse of the DCT-II.

## Multidimensional transforms

The functions `my_fft2` and `my_dct2` perform the 2-dimensional DFT and DCT. Again, the input matrix `A` should ideally have dimensions which are powers of 2, otherwise `A` will be padded with zeroes up to the next power of 2. The functions `my_ifft2` and `my_idct2` invert the process.
