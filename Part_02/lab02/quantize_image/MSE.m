function [ mse ] = MSE( A,B )
%MSE Summary of this function goes here
%   Detailed explanation goes here
A = double(A);
B = double(B);
mse = sum(sum(((A-B).^2) / (size(A,1)*size(A,2))));

end

