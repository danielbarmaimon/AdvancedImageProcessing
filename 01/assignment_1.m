%% Initialization               
clear all; clc; close all;        % Closing and cleaning matlab environment


%% Call to the function
name = 'trui.tif';          % Name of the original image
img = imread(name);         % Reading the image
solution1 = anisotropicDiff(img, 1, 100);
solution2 = anisotropicDiff(img, 10, 100);
solution3 = anisotropicDiff(img, 100, 100);
%solution4 = anisotropicDiff(img, 1000, 100);


%% Showing the results
% figure('Name', 'Non-Linear Averaging and Edge detector - K = 100');
% subplot(2,4,1); imshow(solution1); mt(1) = title('Iterations = 1');
% subplot(2,4,2); imshow(solution2); mt(2) = title('Iterations = 10');
% subplot(2,4,3); imshow(solution3); mt(3) = title('Iterations = 100');
% subplot(2,4,4); imshow(solution4); mt(4) = title('Iterations = 1000');
% set(mt,'Position',[225 530],'VerticalAlignment','top','Color',[0 0 0])

%figure('Name', 'Edges Detection - Canny detector');
%edges = edge(solution1, 'canny');
%edges1 = edge(solution2, 'canny');
%edges2 = edge(solution3, 'canny');
%edges3 = edge(solution4, 'canny');
%subplot(2,4,5); imshow(edges); mt(1) = title('Iterations = 1');
%subplot(2,4,6); imshow(edges1); mt(2) = title('Iterations = 10');
%subplot(2,4,7); imshow(edges2); mt(3) = title('Iterations = 100');
%subplot(2,4,8); imshow(edges3); mt(4) = title('Iterations = 1000');
%set(mt,'Position',[225 530],'VerticalAlignment','top','Color',[0 0 0])

%% Segmentation with region growing method
%[imOut,~,~] = regionGrowing('lena.png',5,8);
%[imOut1,~,~] = regionGrowing(img,5,8);
%[imOut2,~,~] = regionGrowing(img,5,8);
%[imOut3,~,~] = regionGrowing('lena3.jpg',5,8);
%[imOut4,~,~] = regionGrowing(img,5,8);
%figure('Name', 'Segmentation Original');
%imagesc(imOut);
%figure('Name', 'Segmentation after filtering (k=100, it=100)');
%imagesc(imOut3);

%subplot(1,2,1); imshow(imOut); mt(1) = title('Iterations = 100');
%subplot(1,2,2); imshow(imOut); mt(1) = title('Iterations = 1');
%subplot(1,2,2); imshow(edges1); mt(2) = title('Iterations = 10');
%subplot(1,2,2); imshow(imOut3); mt(2) = title('Iterations = 100');
%subplot(1,2,2); imshow(edges3); mt(4) = title('Iterations = 1000');
%set(mt,'Position',[250 700],'VerticalAlignment','top','Color',[0 0 0])

%h= imshow(solution4);
%lena4.jpeg = imsave(h);

%% Analysis with mesh plot
X = uint8([150:200]);
Y = uint8([150:200]);
Z = solution3(150:200,150:200);
meshgrid(X,Y);
%mesh(double(Z));
surf(double(X),double(Y),double(Z),'FaceColor','interp','EdgeColor','none');
view(-120,50);
