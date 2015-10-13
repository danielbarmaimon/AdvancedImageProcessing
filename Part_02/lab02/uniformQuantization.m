function [ borders,centers ] = uniformQuantization(I, L)
%UNIFORMQUANTIZATION Summary of this function goes here
%   Detailed explanation goes here
% B = 255;
% q = B/n_levels;
% 
% borders = [0,q:q:B];
% h = [1/2,-1/2];
% d_b = conv(borders,h,'valid');
% centers = (borders(1:end-1) + d_b);
I = double(I);              % Cast the image to work with it
f_min = min(I(:));          % Get the minimum gray level
f_max = max(I(:));          % Get the maximum gray level
q = ((f_max-f_min)/L);      % Get the size of each interval

%% Naive quantization
borders = [f_min:q:f_max+(0.1*q)];  % Get the interval borders
h = [1/2,-1/2];                     % Prepare the step to convolve
d_b = (conv(borders,h,'valid'));    % Local position of the center for each interval
centers = d_b + borders(1:end-1);   % Add local position to lower limit to get the center
end

