%% Clear environment
close all;
clc;
clear all;

%% Image that is going to be used
%name = ('cameraman.tif');
%name = ('einstein.jpg');
name = ('lena.png');
%name = ('trui.tif');

imIn = imread(name);
%figure('Name', 'Original');
%imshow(imIn, []);
%title('Original');
%% Blurring the image with a kernel
% Gaussian Kernel
sigma = 3;
h = fspecial('gaussian', size(imIn), sigma);

% Motion Kernel
len = 50;                % Lenth of the displacement
alpha = 45;
h_motion = fspecial('motion', len, alpha);


% Showing the kernel
%figure('Name', 'Blur Kernel');
%imshow(h, []);


% Applying the filter
imBlur = imfilter(imIn,h, 'circular', 'conv');
imBlur2 = imfilter(imIn, h_motion, 'circular','conv');
figure('Name', 'Blurred');
imshow(imBlur);
%imshow(imBlur2);
%-------------------- PART 1 -------- |h?g ? f |^2  - mu|f|^2 -> min
%% Deblurring the image (without noise)
% lam = 80;
% H = fft2(h);        % The kernel should be centered to recover the image later on.
% Hconj = conj(H);
% G = fft2(imBlur);
% F = (Hconj./(Hconj.*H + mu)).*G ;
% %F = (lam * Hconj./(lam * Hconj.*H + 1)).*G;
% f = fftshift(abs(ifft2(F)));
% figure('Name','Recovered');
% imshow(f, []);

% Varying the parameter lambda
% for i = 1:4
% %mu = 1.0 / (10^i);            % Parameter to set up in the model
% lam = 10^i;
% H = fft2(fftshift(h));        % The kernel should be centered to recover the image later on.
% Hconj = conj(H);
% G = fft2(imBlur);
% %F = (Hconj./(Hconj.*H + mu)).*G ;
% F = (lam * Hconj./(lam * Hconj.*H + 1)).*G;
% f = real(ifft2(F));
% str = sprintf('lam = %f', 10^i);
% figure('Name',str);
% f = uint8(f);
% imshow(f);
% %pause;
% end

% % Applying noise to the original image
%imNoisy = imnoise(imBlur, 'gaussian', 0, 0.000001);
%figure;
%imshow(imNoisy);

%% Debluring the noisy image
% % Varying the parameter lambda
% for i = 1:4
% lam = 50+250*(i-1);
% H = fft2(fftshift(h));        % The kernel should be centered to recover the image later on.
% Hconj = conj(H);
% G = fft2(imNoisy);
% F = (lam * Hconj./(lam * Hconj.*H + 1)).*G;
% f = real(ifft2(F));
% str = sprintf('lam = %f', 100+250*(i-1));
% %figure('Name',str);
% f = uint8(f);
% %imshow(f);
% diff= f-imIn;
% figure('Name','Difference');
% imshow(diff);
% %pause;
% end

% Motion blur (no noise)
% lam = 10000;
% %k = 0.00008;
% H2 = psf2otf(h_motion,[size(imIn, 1),size(imIn, 2)]);
% H2conj = conj(H2);
% G2 = fft2(imBlur2);
% F2 = (lam * H2conj./(lam * H2conj.*H2 + 1)).*G2;
% %F2 = (H2conj./(H2conj.*H2 + K)).*G2; 
% f2 = real(ifft2(F2));
% %f2 = ifft2(F2);
% figure('Name','Deblured image (motion kernel)');
% f2 = uint8(f2);
% imshow(f2, []);
% %pause;

% Comparing with matlab Lucy-Richardson deconvolution
% figure('Name','Lucy-Richardson deconvolution');
% imshow(deconvlucy(imNoisy, h));

%-------------------- PART 2 -------- 
% Gaussian blur (with noise)
% %imNoisy = imnoise(imBlur, 'gaussian', 0, 0.00001);    % Gaussian
% %imNoisy = imnoise(imBlur, 'salt & pepper', 0.0005);    % Salt and pepper
% imNoisy = imnoise(imBlur, 'speckle', 0.0004);           % Speckle
% figure;
% imshow(imNoisy);
% 
% lam = 1000;
% H = fft2(h);        % The kernel should be centered to recover the image later on.
% Hconj = conj(H);
% G = fft2(imNoisy);
% %F = (Hconj./(Hconj.*H + mu)).*G ;
% F = (lam * Hconj./(lam * Hconj.*H + 1)).*G;
% f = fftshift(abs(ifft2(F)));
% figure('Name','Recovered');
% imshow(f, []);


%------------------------------------------------
% Motion blur (with noise)
% %imNoisy = imnoise(imBlur2, 'gaussian', 0, 0.000001);    % Gaussian
% %imNoisy = imnoise(imBlur2, 'salt & pepper', 0.0005);    % Salt and pepper
% imNoisy = imnoise(imBlur2, 'speckle', 0.0004);           % Speckle
% figure;
% imshow(imNoisy);
% 
% lam = 7500;
% H2 = psf2otf(h_motion,[size(imIn, 1),size(imIn, 2)]);
% H2conj = conj(H2);
% G2 = fft2(imNoisy);
% F2 = (lam * H2conj./(lam * H2conj.*H2 + 1)).*G2;
% f2 = real(ifft2(F2));
% figure('Name','Deblured noisy image (motion kernel)');
% f2 = uint8(f2);
% imshow(f2);

%-------------------- PART 3 -------- |h?g ? f |^2 - mu|?f|^2 -> min
% Energy 1 ---
lam = 500;
HE1 = fft2(h);        % The kernel should be centered to recover the image later on.
HE1conj = conj(HE1);
GE1 = fft2(imBlur);
%FE1 = (HE1conj./(HE1conj.*HE1 + mu)).*GE1 ;
FE1 = (lam * HE1conj./(lam * HE1conj.*HE1 + 1)).*GE1;
fe1 = fftshift(real(ifft2(FE1)));
figure('Name','Recovered energy 1');
imshow(fe1, []);


% Energy 2 ---
[height,width]=size(imIn);
lam = 500;
%Using the approximation of the lapplacian function
[ X, Y ] = meshgrid(1:height, 1:width);
Flap = exp(-2*pi*1i*X./height) + exp(2*pi*1i*X./height) + exp(-2*pi*1i*Y./width) + exp(2*pi*1i*Y./width) - 4;
%surf(Flap);
HE2 = fft2(fftshift(h)); 
HE2conj = conj(HE2);
FE2 = lam*HE2conj.*GE1./(-Flap+lam*HE2.*HE2conj);
fe2 = real(ifft2(FE2));
figure('Name','Recovered energy 2');
imshow(fe2, []);

% Comparing with Lucy-Richardson deconvolution
figure('Name','Lucy-Richardson');
imshow(deconvlucy(imBlur, h), []);

figure('Name','Difference 1');
imshow(abs(double(imIn)-fe1), []);

figure('Name','Difference 2');
imshow(abs(double(imIn)-fe2), []);

figure('Name','Difference Lucy');
imshow(abs(imIn-deconvlucy(imBlur,h)), []);