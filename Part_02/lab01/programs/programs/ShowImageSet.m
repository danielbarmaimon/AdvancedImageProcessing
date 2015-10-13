

function []=ShowImageSet(ImageSet, ImageNum, ImageTitle)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Purpose:    Show a set of images in one picture
%   Input:      ImageSet------The images to be shown
%                             a 3D matrix(n, m, t), (n,m): image size, t: number of images.
%               ImageNum------Number of images
%               ImageTitle----The title of images to be shown
%   Output:     picture on screen
%
% Xun Wang
% 23/06/2003
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




fax = factor(ImageNum);  
plotHt = prod(fax,2)/fax(length(fax)); 
plotWd = fax(length(fax));

figure

im_min = min(min(min(ImageSet))); 
im_max = max(max(max(ImageSet)));
        
for m=1:ImageNum
    subplot(plotHt,plotWd,m)
    imshow(ImageSet(:,:,m),[im_min im_max]),colormap('gray')
end
title(ImageTitle);

