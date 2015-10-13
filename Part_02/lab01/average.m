im = imread('lena.png');
im_fft = fft2(im2double(im));

magnitude_ = abs(im_fft);
imshow(log(abs(fftshift(im_fft))),[]);
%average from fft:
average_fft = max(magnitude_(:))/(size(im,1)*size(im,2))*255
%average from spatial domain:
average_image = mean(im(:))