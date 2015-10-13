%close all, clear all, clc; 

%% Load an image
im = (imread('lena.png'));

if (size(im,3)==3)
    im=rgb2gray(im);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Implement Haar Wavelet transform and its inverse
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Compare DCT and DWT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPRESSION
% Use DCT for compression
imDCT = dct(im);
% Use DWT for compression
imDWT = HaarTransform(im,1);

%% Calculating the MSE and PSNR varying the number of levels
inf = 1;
sup = 1000;
step = 20;
levels = (inf:step:sup);
[n,m]=size(im);
l = numel(levels);
MSEdctU = zeros(l,1);
PSNRdctU = zeros(l,1);
MSEdwtU = zeros(l,1);
PSNRdwtU = zeros(l,1);
MSEdctO = zeros(l,1);
PSNRdctO = zeros(l,1);
MSEdwtO = zeros(l,1);
PSNRdwtO = zeros(l,1);

for i= 1:l   
    % Quantization using uniform quantization(DCT)
    [ bordersDCT,centersDCT ] = uniformQuantization(imDCT, (levels(i)));
    [~,imDCTq] = quantiz(imDCT(:),centersDCT,bordersDCT);
    imDCTq=reshape(imDCTq,n,m);

    % Quantization using Lloyd(DCT)
%    [ bordersOpDCT,centersOpDCT ]=lloyds(imDCT(:),(1:step:levels(i)));
%    imDCTqOp = quantiz(imDCT(:),bordersOpDCT);
    
    % Quantization using uniform quantization(DWT)
    [ bordersDWT,centersDWT ] = uniformQuantization(imDWT, levels(i));
    [~,imDWTq] = quantiz(imDWT(:),centersDWT,bordersDWT);
    imDWTq=reshape(imDWTq,n,m);
    % Quantization using Lloyd(DWT)
%    [ bordersOpDWT,centersOpDWT ]=lloyds(imDWT,levels(i));
%    imDWTqOp = quantiz(imDWT(:),bordersOpDWT);
    
    % Inverse of uniform quantization(IDCT)
    imIDCTu = idct(imDCTq);
%    imIDCTop = idct2(imDCTqOp, [m n]);
    imIDWTu = inverseHaarTransform(imDWTq,1);
%    imIDWTop = idct2(imDWTqOp, [m n]);

    % Calculate the MSE and PSNR
    [MSEdctU(i), PSNRdctU(i)]= metrics( im, imIDCTu);
%    [MSEdctO(i), PSNRdctO(i)]= metrics( im, imIDCTop);
    [MSEdwtU(i), PSNRdwtU(i)]= metrics( im, imIDWTu);
%    [MSEdwtO(i), PSNRdwtO(i)]= metrics( im, imIDWTop);
end

%% Results for a specific number of levels of quantization --PLOTING 
figure;
subplot(1,3,1);
imshow(im,[]);
title('Original image');
subplot(1,3,2)
imshow(double(imIDCTu),[]);
title('DCT');
subplot(1,3,3);
imshow(double(imIDWTu),[]);
title('DWT');


%% Comparison for the metrics over number of Qlevels
% MSE
figure;
plot(levels, MSEdctU,'b');
hold on;
plot(levels, MSEdwtU,'r');
% PSNR
figure;
plot(levels, PSNRdctU);
hold on;
plot(levels, PSNRdwtU);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %% Comparison for Daubechies with different vanishing moments 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute Daubechies-2 using MATLAB 'dwt2' function
[cA, cB, cC, cD] = dwt2(im,'db1');
imDWT2 = [cA,cB;cC,cD];

% Compute Daubechies-4 using MATLAB 'dwt2' function
[cA, cB, cC, cD] = dwt2(im,'db2');
imDWT4 = [cA,cB;cC,cD];

% Compute Daubechies-6 using MATLAB 'dwt2' function
[cA, cB, cC, cD] = dwt2(im,'db3'); 
imDWT6 = [cA,cB;cC,cD];

% Compute Daubechies-8 using MATLAB 'dwt2' function
[cA, cB, cC, cD] = dwt2(im,'db4'); 
imDWT8 = [cA,cB;cC,cD];

% Compute Daubechies-10 using MATLAB 'dwt2' function
[cA, cB, cC, cD] = dwt2(im,'db5'); 
imDWT10 = [cA,cB;cC,cD];

% Compute Daubechies-12 using MATLAB 'dwt2' function
[cA, cB, cC, cD] = dwt2(im,'db6'); 
imDWT12 = [cA,cB;cC,cD];

inf = 1;
sup = 1000;
step = 20;
levels = (inf:step:sup);
[n,m]=size(im);
l = numel(levels);
MSEdwt2 = zeros(l,1);
MSEdwt4 = zeros(l,1);
MSEdwt6 = zeros(l,1);
MSEdwt8 = zeros(l,1);
MSEdwt10 = zeros(l,1);
MSEdwt12 = zeros(l,1);
PSNRdwt2 = zeros(l,1);
PSNRdwt4 = zeros(l,1);
PSNRdwt6 = zeros(l,1);
PSNRdwt8 = zeros(l,1);
PSNRdwt10 = zeros(l,1);
PSNRdwt12 = zeros(l,1);

for i= 1:l       
    % Quantization using uniform quantization(DWT)
    [ bordersDWT2,centersDWT2 ] = uniformQuantization(imDWT2, levels(i));
    [~,imDWT2q] = quantiz(imDWT2(:),centersDWT2,bordersDWT2);
    imDWT2q=reshape(imDWT2q,size(imDWT2,1),size(imDWT2,2));   
    [r,c]=size(imDWT2q);    
    cA2 = imDWT2q(1:r/2,1:c/2); cC2 = imDWT2q(r/2+1:r,1:c/2);
    cB2 = imDWT2q(1:r/2,c/2+1:c); cD2 = imDWT2q(r/2+1:r,c/2+1:c);  
    % Quantization using uniform quantization(DWT)
    [ bordersDWT4,centersDWT4 ] = uniformQuantization(imDWT4, levels(i));
    [~,imDWT4q] = quantiz(imDWT4(:),centersDWT4,bordersDWT4);
    imDWT4q=reshape(imDWT4q,size(imDWT4,1),size(imDWT4,2));
    [r,c]=size(imDWT4q);   
    cA4 = imDWT4q(1:r/2,1:c/2); cC4 = imDWT4q(r/2+1:r,1:c/2);
    cB4 = imDWT4q(1:r/2,c/2+1:c); cD4 = imDWT4q(r/2+1:r,c/2+1:c);
    % Quantization using uniform quantization(DWT)
    [ bordersDWT6,centersDWT6 ] = uniformQuantization(imDWT6, levels(i));
    [~,imDWT6q] = quantiz(imDWT6(:),centersDWT6,bordersDWT6);
    imDWT6q=reshape(imDWT6q,size(imDWT6,1),size(imDWT6,2));
    [r,c]=size(imDWT6q);
    cA6 = imDWT6q(1:r/2,1:c/2); cC6 = imDWT6q(r/2+1:r,1:c/2);
    cB6 = imDWT6q(1:r/2,c/2+1:c); cD6 = imDWT6q(r/2+1:r,c/2+1:c);
    % Quantization using uniform quantization(DWT)
    [ bordersDWT8,centersDWT8 ] = uniformQuantization(imDWT8, levels(i));
    [~,imDWT8q] = quantiz(imDWT8(:),centersDWT8,bordersDWT8);
    imDWT8q=reshape(imDWT8q,size(imDWT8,1),size(imDWT8,2));   
    [r,c]=size(imDWT8q);    
    cA8 = imDWT8q(1:r/2,1:c/2); cC8 = imDWT8q(r/2+1:r,1:c/2);
    cB8 = imDWT8q(1:r/2,c/2+1:c); cD8 = imDWT8q(r/2+1:r,c/2+1:c);  
    % Quantization using uniform quantization(DWT)
    [ bordersDWT10,centersDWT10 ] = uniformQuantization(imDWT10, levels(i));
    [~,imDWT10q] = quantiz(imDWT10(:),centersDWT10,bordersDWT10);
    imDWT10q=reshape(imDWT10q,size(imDWT10,1),size(imDWT10,2));
    [r,c]=size(imDWT10q);   
    cA10 = imDWT10q(1:r/2,1:c/2); cC10 = imDWT10q(r/2+1:r,1:c/2);
    cB10 = imDWT10q(1:r/2,c/2+1:c); cD10 = imDWT10q(r/2+1:r,c/2+1:c);
    % Quantization using uniform quantization(DWT)
    [ bordersDWT12,centersDWT12 ] = uniformQuantization(imDWT12, levels(i));
    [~,imDWT12q] = quantiz(imDWT12(:),centersDWT12,bordersDWT12);
    imDWT12q=reshape(imDWT12q,size(imDWT12,1),size(imDWT12,2));
    [r,c]=size(imDWT12q);
    cA12 = imDWT12q(1:r/2,1:c/2); cC12 = imDWT12q(r/2+1:r,1:c/2);
    cB12 = imDWT12q(1:r/2,c/2+1:c); cD12 = imDWT12q(r/2+1:r,c/2+1:c);
    
    
    
    % Inverse of uniform quantization(IDCT)
    imIDWT2u = idwt2(cA2,cB2,cC2,cD2,'db1');
    imIDWT4u = idwt2(cA4,cB4,cC4,cD4,'db2');
    imIDWT6u = idwt2(cA6,cB6,cC6,cD6,'db3');
    imIDWT8u = idwt2(cA8,cB8,cC8,cD8,'db4');
    imIDWT10u = idwt2(cA10,cB10,cC10,cD10,'db5');
    imIDWT12u = idwt2(cA12,cB12,cC12,cD12,'db6');
  

    % Calculate the MSE and PSNR
    [MSEdwt2(i), PSNRdwt2(i)]= metrics( im, imIDWT2u);
    [MSEdwt4(i), PSNRdwt4(i)]= metrics( im, imIDWT4u);
    [MSEdwt6(i), PSNRdwt6(i)]= metrics( im, imIDWT6u);
    [MSEdwt8(i), PSNRdwt8(i)]= metrics( im, imIDWT8u);
    [MSEdwt10(i), PSNRdwt10(i)]= metrics( im, imIDWT10u);
    [MSEdwt12(i), PSNRdwt12(i)]= metrics( im, imIDWT12u);
end

%% Results for a specific number of levels of quantization

% figure;
% subplot(1,3,1);
% imshow(im,[]);
% title('Original image');
% subplot(1,3,2)
% imshow(double(imIDCTu),[]);
% title('DCT');
% subplot(1,3,3);
% imshow(double(imIDWTu),[]);
% title('DWT');


%% Comparison for the metrics over time
% MSE
figure;
plot(levels, MSEdwt2,'b');
hold on;
plot(levels, MSEdwt4,'r');
plot(levels, MSEdwt6,'g');
plot(levels, MSEdwt8,'Color',[1 1 0]);
plot(levels, MSEdwt10,'Color',[1 0 1]);
plot(levels, MSEdwt12,'Color',[0 1 1]);
% PSNR
figure;
plot(levels, PSNRdwt2,'b');
hold on;
plot(levels, PSNRdwt4,'r');
plot(levels, PSNRdwt6,'g');
plot(levels, PSNRdwt8,'Color',[1 1 0]);
plot(levels, PSNRdwt10,'Color',[1 0 1]);
plot(levels, PSNRdwt12,'Color',[0 1 1]);
