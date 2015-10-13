%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%
% 2 Dimensional Inverse Fourier Transform
%
%       [ima] = ifft2d(ima_in)
%
% This function calculates the complex Inverse Fourier transform
%  of the complex image ima_in. 
%
%       ima_in : complex input image
%       ima : output (possibly complex) image
%             real and imaginary part can be accessed through real
%             and imag function (see help real, imag)
%
%
% Yvan Petillot, December 2000                                  
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ima = ifft2d(ima_in)
  
  ima = fftshift(ifft2(fftshift(ima_in)));
  %Display results
  clf;       %Clear display
  figure(1); %Create figure
  imagesc(abs(ima)); % Scale image to [0 255] range and siplay it
  axis square;     % Display equal on x and y axes
  colormap(gray);  % Sets gray scale colormap;
  drawnow;         % Ready to dipslay: Do it
  

