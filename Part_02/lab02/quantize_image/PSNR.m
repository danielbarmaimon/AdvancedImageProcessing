function [ psnr ] = PSNR( A,B )
%PSNR Summary of this function goes here
%   Detailed explanation goes here
A = double(A);
B = double(B);

err = sum(((A(:)-B(:)).^2))/prod(size(A));

psnr = 10*log10(255^2/err);


end

