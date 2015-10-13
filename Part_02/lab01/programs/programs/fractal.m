% This functions generates fractals from seeds at various locations
% and for various Beta parameters
% Input:
%		Beta: an array of betas, one for each seed 
%		sources: Position of the sources in the frequency plane as
%					ans array of [line col] positions.
% Examples:
%     fractal(1.3,[128,128]);
%     fractal(2,[128,128]);
%		fractal(2,[120,120]);
%		fractal([2 2],[120 125;130 135];
%		fractal([2 2 2],[120 120; 120 150;180 125]);

function ima = fractal(Beta,sources)

s = [128 128];
nb_sources = size(sources,1)
% This generate a 128 by 128 random pahse image in range -pi to pi
phase = 2*pi*rand(s(1),s(2));
% This creates a zero frequeny spectrum - on which to superimpose magnitude
% values
imafft = zeros(s(1),s(2));
% This creates the superimposition of each source in the correct point in
% frequency plane
for x = 1:s(1)
   for y = 1: s(2)
      for k = 1 : nb_sources
         f = sqrt((x-sources(k,1))^2+(y-sources(k,2))^2);
      	if (f~=0)
         	imafft(x,y) = imafft(x,y)+1/f^Beta(k);
         end	
      end	
   end	
end	
% To create final spectrum, multiply magnitude by phase
imafft = imafft.*exp(i*phase);
% Then inverse transform to get final image
ima = ifft2(fftshift(imafft));
% Show final image
imagesc(real(ima));
