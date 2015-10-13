close all, clear all, clc; 

%% Load an image
im = double(imread('lena.png'));

if (size(im,3)==3)
    im=rgb2gray(im);
end
%% Implement Haar Wavelet transform and its inverse
iter = 2;      % Number of iterations
imOut = im;
figure;
imshow(imOut,[]);
pause;
result = imOut;
temp = imOut;

imHaar = HaarTransform(im,iter);
figure;
imshow(imHaar, []);
figure;
imOrig = inverseHaarTransform(imHaar,iter);
imshow(imOrig,[]);

%% Quantization
