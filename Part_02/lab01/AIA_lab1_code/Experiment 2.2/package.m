im = imread('circuit.tif');
% (a)	Mul1tiply the input image by (-1)x+y to center the transform for filtering.
[ai, aj] = size(im);
im_mod = zeros(ai, aj);
for ii = 1:ai
    for jj = 1:aj
      im_mod(ii, jj) = im(ii, jj)*((-1)^(ii+jj)); 
    end
end
%%
% (b)	Compute the 2-D DFT and  the spectrum
im_fft = fft2d(im_mod);
%%
% (b) Multiply the resulting (complex) array by a real filter function (in the sense that the the real coefficients multiply both the real and imaginary parts of the transforms).   And compute the spectrum.
ideal = zeros(ai, aj);
for ii = 1:ai
    for jj = 1:aj
      if ((ii-ai/2)*(ii-ai/2)+(jj-aj/2)*(jj-aj/2))<1000 
          ideal(ii, jj) = 1; 
      end
    end
end
im_fft_low = im_fft.*ideal;
%%
% (c) Compute the inverse 2-D Fourier transform.
im_fft_low_inv = ifft2d(im_fft_low);
%%
% (d) Multiply the result by (-1)x+y and take the real part.
for ii = 1:ai
    for jj = 1:aj
      im_fft_low_inv = im_fft_low_inv*((-1)^(ii+jj)); 
    end
end
%%
im_fft_low_inv_abs = abs(im_fft_low_inv); 
% (e)  Display the image
imshow(im_fft_low_inv_abs, []);