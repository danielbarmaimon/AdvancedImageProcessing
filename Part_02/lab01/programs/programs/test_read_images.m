%example of using read_images.m
clear all;
clc;

% %   Read in training images
% d = 'H:\mydir\Data\coil-100\coil-100';
% for i = 1:4
%     n(i,:) = strcat('obj',cellstr(num2str(i+7)));
% end
% n(1,:) = cellstr('obj1');
% n(2,:) = cellstr('obj6');
% n(3,:) = cellstr('obj8');
% n(4,:) = cellstr('obj12');
% 
% 
% d = 'H:\mydir\Data\Data_simu\data_30\B_a';
% n = 'B_a';
% Train_set=read_images(d, n, 1, 30);


%   Read in test images
d = 'H:\mydir\Data\coil-100\coil-100';
n = 'obj1__35.png';
Test_im=read_images(d, n, 1, 1);
Test_im = imnoise(Test_im, 'Gaussian', 0, 0.2e-4);

