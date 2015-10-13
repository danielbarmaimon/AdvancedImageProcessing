%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% 2 Dimensional Fourier Transform
%
% [imafft,mag,phi] = fft2d(ima_in)
%
% This function calculates the complex Fourier transform
% and the associated magnitude and phase (mag, phi) of the input real
% image ima_in.
%
% ima_in : real input image
% imafft : output complex image
% real and imaginary part can be accessed through real
% and imag function (see help real, imag)
%
% mag,phi: magnitude and phase of the fourier transform
%
% Yvan Petillot, December 2000
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [imafft,mag,phi] = fft2d(ima_in)
imafft = fftshift(fftn(single((fftshift(ima_in)))));
mag = abs(imafft);
phi = angle(imafft);
%Display results
clf; %Clear display
figure(1); %Create figure
title('Demo of the fourier transform')
subplot(1,3,1); %Separate figure in 3 and selects 1st partition
imagesc(ima_in); % Scale image to [0 255] range and display it
title('Original image');
axis image; % Display equal on x and y axes
%colormap(gray); % Sets gray scale colormap;
axis off;
subplot(1,3,2); % Selects the second partition
imagesc(log(mag+1)); % Display magnitude
title('Magnitude of the spectrum');
axis image; % Display equal on x and y axes
axis off;
subplot(1,3,3); % Selects the second partition
imagesc(phi); % Display phase
axis image; % Display equal on x and y axes
title('Phase of the spectrum');
axis off;
drawnow; % Ready to display: Do it
