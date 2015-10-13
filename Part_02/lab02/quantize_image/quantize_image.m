function [ I_f ] = quantize_image( I,borders,centers )
%QUANTIZE_IMAGE Summary of this function goes here
%   Detailed explanation goes here

I_f = zeros(size(I));
for ii=1:size(borders,2)-1
   I_f(I>=borders(ii) & I<borders(ii+1)) = centers(ii); 
end
I_f(I>=borders(end)) = centers(end);

end

