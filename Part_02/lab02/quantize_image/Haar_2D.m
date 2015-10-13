function [ R, Blur,Vert,Hort,Diag ] = Haar_2D(I)
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

H(u_1_v) = 1;
H(u_2_v) = 1;
G(u_1_v) = -1;
G(u_2_v) = 1;
G = 1/(2)*G;
H = 1/(2)*H;

Blur = (H*I*H');
Vert = (H*I*G');
Hort = (G*I*H');
Diag = (G*I*G');


R = [Blur,Vert;Hort,Diag];
end

