# fft-project
MATLAB code for a project on the Fast Fourier Transform

# Usage

## FFT functions

The function `my_fft` takes as input a row vector `f` and returns its discrete Fourier transform as a row vector `F`. If the length of `f` is a power of 2, then `F` will be the same length. If the length of `f` is not a power of 2, then `f` will be padded with zeroes so that its length is a power of 2, and `F` will be the DFT of the padded vector. If possible, it is best to avoid inputting vectors whose length is not a power of 2. The function `my_ifft` behaves similarly, but returns the inverse DFT.

```matlab
>> f = rand(1,4) + 1i*rand(1,4)

f =

   0.3835 + 0.6944i   0.5319 + 0.0586i   0.9283 + 0.4466i   0.4586 + 0.8500i
   
>> F = my_fft(f) % returns the discrete Fourier transform of f

F =

   2.3023 + 2.0495i  -1.3361 + 0.1744i   0.3213 + 0.2324i   0.2466 + 0.3210i

>> my_ifft(F) % should be the same as f

ans =

   0.3835 + 0.6944i   0.5319 + 0.0586i   0.9283 + 0.4466i   0.4586 + 0.8500i
   
```

## Real FFT functions

In the case where `f` contains real numbers only, the function `realfft` can be used instead. In the case of a vector `F` whose inverse DFT is known to be real, the function `realifft` can be used.

```matlab
>> f = rand(1,4);

f =

    0.4508    0.6783    0.3105    0.1409

>> F = realfft(f)

F =

   1.5804 + 0.0000i   0.1403 - 0.5374i  -0.0579 - 0.0000i   0.1403 + 0.5374i
   
>> realifft(F) % should be the same as f

ans =

    0.4508    0.6783    0.3105    0.1409
    
```

## Discrete sine and cosine transforms

The function `my_dst` takes as input a row vector `f` and returns its discrete sine transform. The length of `f` must be a power of 2, it must begin with `0`, and its entries should all be real numbers. The function `my_idst` returns the inverse DST.

The function `my_dct` takes as input a row vector `f`, whose components should all be real, and whose length should be a power of 2, and returns its discrete cosine transform (DCT-II). The function `my_idct` returns the DCT-III, which is the inverse of the DCT-II.

## Multidimensional transforms

The functions `my_fft2` and `my_dct2` perform the 2-dimensional DFT and DCT. Again, the input matrix `A` should ideally have dimensions which are powers of 2, otherwise `A` will be padded with zeroes up to the next power of 2. The functions `my_ifft2` and `my_idct2` invert the process.

## Heat equation

The script `heateqn` produces a numerical solution to the heat equation. It is a good idea to try changing the initial condition `u0 = @(x) sin(x);` to something more interesting like `u0 = @(x) sin(x) + 2*sin(2*x) + 4*sin(4*x)`. To calculate a solution over a longer or shorter period of time, change the value of `N`.

## JPEG compression 

The script `jpegcompression` demonstrates how the 2-dimensional DCT can be used to compress image files. The default image provided is `bee.png`, but try replacing it with other grayscale images. For a different level of compression, change the value of `quality` to any number between 0 and 100.

# Other included functions

* `bitreverseperm`

Returns the bit-reversal permutation `Y` of a column vector `y`.

```matlab
>> bitreverseperm((0:7)')

ans =

     0
     4
     2
     6
     1
     5
     3
     7
```

* `padwithzeroes`

Takes as input a matrix `x` and an optional parameter `N`, and adds columns of zeroes to the right of `x` so that it has `N` columns. If `N` is not specified, it is taken to be the next power of 2 greater than or equal to `size(x,2)`.

```matlab
>> x = rand(1,3)

x =

    0.0118    0.1695    0.2711
    
>> padwithzeroes(x)

ans =

    0.0118    0.1695    0.2711         0
    
>> A = rand(3,5)

A =

    0.7575    0.0242    0.5726    0.0376    0.2321
    0.1780    0.9051    0.5313    0.3467    0.2633
    0.2940    0.0186    0.6569    0.3265    0.8605
    
>> padwithzeroes(A, 10)

ans =

    0.7575    0.0242    0.5726    0.0376    0.2321         0         0         0         0         0
    0.1780    0.9051    0.5313    0.3467    0.2633         0         0         0         0         0
    0.2940    0.0186    0.6569    0.3265    0.8605         0         0         0         0         0
    
```

* `slow_dft`, `fft_recursive`, `fft_iterative`

Matrix multiplication, recursive, and iterative FFT algorithms, included only to show the difference in their runtimes. All three functions return the same result (up to error), and take an optional parameter `isign` which can either be `-1` for the forward DFT or `1` for the inverse DFT. If left unspecified, `isign` is taken to be `-1`.

```matlab
>> x = rand(1,2^10);
>> tic; slow_dft(x); toc
Elapsed time is 0.280812 seconds.
>> tic; fft_iterative(x); toc
Elapsed time is 0.008430 seconds.
>> tic; fft_recursive(x); toc
Elapsed time is 0.165848 seconds.

```

* `slow_dst`, `slow_dct`, `slow_idct`

Functions for computing the DST, DCT-II, and DCT-III directly from the definition, included only to demonstrate that `my_dst`, `my_dct`, and `my_idct` are faster.

```matlab
>> x = rand(1,2^10); x(1) = 0;
>> tic; slow_dst(x); toc
Elapsed time is 0.132693 seconds.
>> tic; my_dst(x); toc
Elapsed time is 0.039330 seconds.
```
