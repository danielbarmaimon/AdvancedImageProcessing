clear all;
close all;

im = im2double(imread('lena.png'));
% im = im2double(imread('cameraman.tif'));

im_noisy = imnoise(im,'gaussian',0,0.01);

im_nlmeans = FAST_NLM_II(im_noisy,5,3,0.15);
figure,imshow([im,im_noisy,im_nlmeans]);

s=size(im)
hline = 150; % 
figure,
subplot(3,1,1); plot(im(hline,:)); axis([0 s(2) 0 1]); title('original signal');
subplot(3,1,2); plot(im_noisy(hline,:)); axis([0 s(2) 0 1]); title('noisy signal');
subplot(3,1,3); plot(im_nlmeans(hline,:)); axis([0 s(2) 0 1]); title('smoothed signal');

