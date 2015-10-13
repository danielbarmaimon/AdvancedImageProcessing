close all;
clear all;

% original image
f = im2double(imread('trui.tif'));

% gaussian blur psf
% h = fspecial('gaussian',size(f),5);
% motion blur psf
h = fspecial('motion',100,30);

% create blurred image
blurred = imfilter(f,h,'circular'); 

% add some noise
noise = 0.001.*randn(size(f));
g = blurred+noise; 

% show degraded image
figure, imshow(g);

% deblurring 
K = 0.0001;
G = fft2(g); 
% H = fft2(h,size(f, 1),size(f, 2));
% better to use psf2otf to avoid some mess with fftshift
H = psf2otf(h,[size(f, 1),size(f, 2)]);
Hconj = conj(H);
F = (Hconj./(Hconj.*H + K)).*G; 
f_restor = ifft2(F); 

% show reconstructed image
figure, imshow(f_restor);

