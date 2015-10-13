im = imread('lena.png');

%Quantification of the Fourier Transform
%       [ima,imafft,mag_quant,phi_quant] = quant_fft(ima_in,max_level,nb_levels_mag,nb_levels_ophi)

im1 = quant_fft(im, 256, 500, 500);
figure, imshow(im1, []);