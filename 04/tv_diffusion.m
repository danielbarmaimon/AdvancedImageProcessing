clear all;

% im = imread('images/lena.png');
% im = imread('images/trui.tif');
im = imread('cameraman.tif');
% im = imread('images/barbara.tif');
% Note: "im2double" makes image range 0..1
Io = im2double(im(:,:,1));

%%% Add noise
std_n=0.08; % Gaussian noise standard deviation
In = randn(size(Io))*std_n; % White Gaussian noise
Io = Io + In;  % noisy input image

I = Io;

dx = [ -1  0  1]./2;   
dy = [ -1 ; 0 ; 1 ]./2;

figure,imshow(I),title(['original']);

eps = 0.0001;

niter = 100; dt = 0.001; 
for i = 1:niter   

  Ix = imfilter(I,dx,'replicate');
  Iy = imfilter(I,dy,'replicate');
  nI = sqrt(Ix.*Ix+Iy.*Iy)+eps;
  tvgrad = imfilter(Ix./nI,dx,'replicate')+imfilter(Iy./nI,dy,'replicate');
 
  I = I + dt*tvgrad; % +dt*(Io-I)*10;
  
end

figure,imshow(I),title(['tv-diffused']);


