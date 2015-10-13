%% Initialization               
close all; clear all; clc;        % Closing and cleaning matlab environment


%% Call to the function
name = 'cameraman.tif';          % Name of the original image
img = imread(name);         % Reading the image

%% Apply Hough transform
solution = hough(img);
imshow(uint8(1.5*solution));