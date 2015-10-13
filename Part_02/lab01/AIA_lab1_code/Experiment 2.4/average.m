im = imread('lena.png');

%Quantification of the Fourier Transform
%       [ima,imafft,mag_quant,phi_quant] = quant_fft(ima_in,max_level,nb_levels_mag,nb_levels_ophi)
[n,m]=size(im);
im1 = quant_fft(im, n*m, round(n*m), round(0.00001*n*m));
figure, imshow(im1, []);