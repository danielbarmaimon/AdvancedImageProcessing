im = imread('circuit.tif');
im_fft = fft2(im2double(im_mod));

magnitude_ = abs(im_fft);
imshow(log(abs(fftshift(im_fft))),[]);
%average from fft:
average_fft = max(magnitude_(:))/(size(im,1)*size(im,2))
%average from spatial domain:
average_image = mean(im(:))/2