function [ borders,centers ] = NaiveQuantization( I,L )
%NAIVEQUANTIZATION Summary of this function goes here
%   Detailed explanation goes here
% B = 255;
% q = B/n_levels;
% 
% borders = [0,q:q:B];
% h = [1/2,-1/2];
% d_b = conv(borders,h,'valid');
% centers = (borders(1:end-1) + d_b);
I = double(I);
f_min = min(I(:));
f_max = max(I(:));
% L = 4;
q = ((f_max-f_min)/L);

%% Naive quantization
borders = [f_min:q:f_max+(0.1*q)];
h = [1/2,-1/2];
d_b = (conv(borders,h,'valid'));
centers = d_b + borders(1:end-1);


end

