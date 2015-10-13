%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%
% This function takes the fft of the input image, gets the phase of the spectrum and
% replaces it by a random phase
%
%       ima_out = random_phase(ima)
%
% Yvan Petillot, December 2001                                
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ima_out = random_phase(ima);

 % Get fourier transform first
 imafft = fft2(ima);
 
 % Gets magnitude and phase.
 mag = abs(imafft);
 phi = angle(imafft);
 s = size(ima);
 rand_phase = 4*pi*(rand(s(1),s(2))-0.5);  %random phase between 0 and 2pi
 % Generates the modified spectrum
 newfft = mag.*exp(i*rand_phase);
 
 ima_out = ifft2(newfft);
 
 figure(2);
 colormap(gray);
 imagesc(abs(ima_out));
 axis image;
 title('Ramdom phase version');
 
