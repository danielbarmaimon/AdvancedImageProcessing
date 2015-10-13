function [Train_set]=read_images(Ob_dir, Ob_nam, No_obj, No_ima);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   To read in images, convert each image to a vector, and save them to a 2D matrix
%
%   Ob_dir: 
%   case 1---each object have a unique directory, e.g. d:\images\dog\;
%   case 2---or all object share the same directory, e.g. d:\images\;
%   Ob_nam: consists of a name and number from 0, e.g. dog_0, dog_1...;
%   No_obj: number of objects;
%   No_ima: number of images of each object;
%
%   Xun Wang
%   last verify: 13/12/2004
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:No_obj;
    disp(['Reading images of object',num2str(i),' ...']);
    if No_ima>1
        for j = 0:(No_ima-1);
            m = (i-1)*No_ima+(j+1);
            %case 1
            Ima = double(imread(strcat(Ob_dir(i,:),'\',Ob_nam(i,:), '_', num2str(j),'.jpg')));
            Train_set_1(:,:,m) = Ima;
%             %case 2
%             Ima = imread(char(strcat(Ob_dir,'\',Ob_nam(i,:), '__', num2str(j*5),'.png')));
%             Train_set_1(:,:,m) = double(rgb2gray(Ima));
        end
    else
        Ima = imread(char(strcat(Ob_dir,'\',Ob_nam)));
        Train_set_1 = double(rgb2gray(Ima));
    end
end

n = size(Train_set_1);
m = No_obj*No_ima;
for i = 1:m
    Train_set(:,i) = reshape(Train_set_1(:,:,i),n(1)*n(2),1);
end

Train_set = Energy_Norm(Train_set);








