
%% init
clear all;
close all;

% load blurred image
g = double(rgb2gray(imread('input/1.jpg')));
% g = double(imread('input/barbara.tif'));
% g = double(imread('input/einstein.jpg'));
% g = double(imread('input/cameraman.tif'));
% g = double(imread('input/lena.png'));

% if it's color image, convert it to grayscale
if size(g,3) > 1
   g = rgb2gray(g); 
end
% scale pixels to [0, 1] range
g = g ./ 255.0;
[ N, M ] = size(g);

%imwrite(g, 'results\cameraman-input.png');

figure,
imshow(g, []);

% define deconvolution point spread function
h_sigma = 2;
h = fspecial('gaussian', size(g), h_sigma);
h_motion = fspecial('motion', 100, 45);
h_wrong = fspecial('motion', 100, 90);
%h = h ./ max(max(h));
H = fft2(h);
Hbar = conj(H);

% blur input with known kernel
g = imfilter(g, h, 'circular', 'conv');
% g_motion = imfilter(g, h_motion, 'circular', 'conv');

% add noise
g = imnoise(g, 'gaussian', 0, 0.00005);
% g = imnoise(g, 'speckle', 0.0005);
% g = imnoise(g, 'salt & pepper', 0.0005);

%g_motion = imnoise(g_motion, 'salt & pepper', 0.00005);


% find Fourier transform of input
G = fft2(g);
G_MOTION = fft2(g_motion);

figure('Name', 'Input image'),
imshow(g_motion);

% define Laplacian

[ X, Y ] = meshgrid(1:N, 1:M);
H_lap = exp(-2*pi*1i*X./N) + exp(2*pi*1i*X./N) + exp(-2*pi*1i*Y./M) + exp(2*pi*1i*Y./M) - 4; %symbol of discrete Laplacian

%% debluring

% parameter
lam = 60; % experimentally determined constant

% perform deconvolution
f_result =  real(fftshift(ifft2(lam * Hbar .* G ./ (1 + lam * H .* Hbar))));
%[ f_result_3, ~ ] = deconvblind(g, h);

% second energy
lam = 180;
%ul2grad = real(ifft( lam*Fkbar.*fft(hblurnoise)./(-Flap+lam*Fk.*Fkbar) ));
% f_result_2 =  real(fftshift(ifft2(lam * Hbar .* G ./ ( -H_lap + lam * H .* Hbar))));

%% motion deblur
% deblurring 
K = 0.00000001;

% H = fft2(h,size(f, 1),size(f, 2));
% better to use psf2otf to avoid some mess with fftshift
H = psf2otf(h_wrong,[size(g, 1),size(g, 2)]);
Hconj = conj(H);
F = (Hconj./(Hconj.*H + K)).*G_MOTION; 
f_restor = ifft2(F);

% display result
figure('Name', 'Deconvolution result 1'),
imshow(f_result);

% display result
figure('Name', 'Deconvolution result 2'),
%imshow(f_result_2, []);

% display result
figure('Name', 'Deconvolution motion'),
imshow(f_restor, []);
