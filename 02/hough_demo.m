clear all;

c=imread('cameraman.tif');

edges=edge(c,'canny');

figure,
imshow(edges);

hc=hough(c);

figure,
imshow(mat2gray(hc)*1.5)

[r,theta]=find(hc>90);

c2=imadd(imdivide(c,4),192);

line1 = 8;
line2 = 2;
figure,
imshow(c2)
for i=1:numel(r)
    houghline(c,r(i),theta(i))
    %houghline(c,r(line2),theta(line2))
end

