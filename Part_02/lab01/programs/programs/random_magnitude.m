%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%
% This function takes the fft of the input image, gets the magnitude and phase 
% of the spectrum and replaces the magnitude by a random number
%
%       ima_out = random_magnitude(ima)
%
% Yvan Petillot, December 2001                                
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ima_out = random_magnitude(ima);

 % Get fourier transform first
 imafft = fft2(ima);
 
 % Gets magnitude and phase.
 mag = abs(imafft);
 maxm = max(max(mag));
 phi = angle(imafft);
 s = size(ima);
 rand_mag = maxm*rand(s(1),s(2));
 
 % Generates the modified spectrum
 newfft = rand_mag.*exp(i*phi);
 
 ima_out = ifft2(newfft);
 
 figure(2);
 imagesc(abs(ima_out));
 axis image;
 title('Random magnitude version');
 
