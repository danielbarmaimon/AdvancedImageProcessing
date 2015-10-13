function [ MSE, PSNR ] = metrics( imIn, imOut )
%METRICS Summary of this function goes here
%   Detailed explanation goes here
[r, c] = size(imIn);
% MSE Calculation
MSE = (sum(sum((double(imIn)-double(imOut)).^2)))/(r*c);
% PSNR Calculation
PSNR = 10*log10(255*255/MSE);

end

