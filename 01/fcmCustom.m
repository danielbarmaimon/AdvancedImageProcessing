% This Matlab script illustrate how to use two images as input for FCM segmentation

clc
clear all


%Load GADO image
info = imfinfo('coins.png');
I = im2double(imread('coins.png'));
I = imadjust(I);
%I = double(imread('coins.png'));

%Load AXIAL FLAIR image
%info2 = imfinfo('FLAIRimage.jpg');
%I2 = im2double(imread('FLAIRimage','jpg'));
%I2 = imadjust(I);

figure;imshow(I,[]);impixelinfo; % Show Image I
  
%data = [I(:) I2(:)]; % data array
data = I(:);

[center,U,obj_fcn] = fcm(data,7); % Fuzzy C-means classification with 7 classes
         
% Finding the pixels for each class
maxU = max(U);
index1 = find(U(1,:) == maxU);
index2 = find(U(2,:) == maxU);
index3 = find(U(3,:) == maxU);
index4 = find(U(4,:) == maxU);
index5 = find(U(5,:) == maxU);
index6 = find(U(6,:) == maxU);
index7 = find(U(7,:) == maxU);
 
% Assigning pixel to each class by giving them a specific value
fcmImage(1:length(data))=0;       
fcmImage(index1)= 1;
fcmImage(index2)= 0.875;
fcmImage(index3)= 0.70;
fcmImage(index4)= 0.425;
fcmImage(index5)= 0.35;
fcmImage(index6)= 0.175;
fcmImage(index7)= 0.0;
%fcmImage(index2)= 0.75;
%fcmImage(index3)= 0.5;
%fcmImage(index4)= 0.25;
%fcmImage(index5)= 0;
%fcmImage(index6)= 0;
% Reshapeing the array to a image
imagNew = reshape(fcmImage,246,[]);
figure;imshow(imagNew,[]);impixelinfo;