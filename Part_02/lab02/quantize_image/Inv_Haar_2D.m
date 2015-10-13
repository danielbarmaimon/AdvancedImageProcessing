function [ R ] = Inv_Haar_2D(I)
%2D_HAAR Summary of this function goes here
%   Detailed explanation goes here
I = double(I);
H = zeros(size(I,1)/2,size(I,2));
G = zeros(size(I,1)/2,size(I,2));

u_1 = 1:2:size(I,2);
u_2 = 2:2:size(I,2);
v = 1:size(I,1)/2;
u_1_v = sub2ind(size(H),v,u_1);
u_2_v = sub2ind(size(H),v,u_2);

H(u_1_v) = 1.0;
H(u_2_v) = 1.0;
G(u_1_v) = -1.0;
G(u_2_v) = 1.0;

B = I(1:size(I,1)/2,1:size(I,2)/2);
Ve = I(1:size(I,1)/2,size(I,2)/2+1:size(I,2));
Ho = I(size(I,1)/2+1:size(I,1),1:size(I,2)/2);
Di = I(size(I,1)/2+1:size(I,1),size(I,2)/2+1:size(I,2));

Blur = (H'*B*H);
Vert = (H'*Ve*G);
Hort = (G'*Ho*H);
Diag = (G'*Di*G);


R = Blur+Vert+Hort+Diag;
end

