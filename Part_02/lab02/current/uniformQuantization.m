function [ borders,centers ] = uniformQuantization(im, levels)
%UNIFORMQUANTIZATION Summary of this function goes here
%   Detailed explanation goes here

im = double(im);             % Cast the image to work with it
f_min = min(im(:));          % Get the minimum gray level
f_max = max(im(:));          % Get the maximum gray level
q = ((f_max-f_min)/levels);      % Get the size of each interval

%% Uniform quantization
borders = [f_min:q:f_max+(0.1*q)];  % Get the interval borders
h = [1/2,-1/2];                     % Prepare the step to convolve
d_b = (conv(borders,h,'valid'));    % Local position of the center for each interval
centers = d_b + borders(1:end-1);   % Add local position to lower limit to get the center
end

