%% Experiment 1 - Phase and magnitude manipulation
% % Get the phase from an image
% im1 = imread('circuit.tif');
% figure;
% imagesc(im1);       %imshow(im1);
% title('Original image');
% 
% % Separate phase and magnitude and reconstruct the image
% fourier = fft2(im1);
% magnitude = log(abs(fourier));
% phase = angle(fourier);
% invMagnitude = ifft2(10.^magnitude);
% figure;
% imagesc(invMagnitude);      %imshow(invMagnitude, []);
% axis image;
% title('Magnitude only version');
% invPhase = ifft2(cos(phase)+ 1i.*sin(phase));
% figure;
% imagesc(abs(invPhase));     %imshow(invPhase, []);
% axis image;
% title('Phase only version');
% original =ifft2(exp(magnitude).*(cos(phase)+ 1i.*sin(phase)));
% figure;
% imagesc(abs(original));%imshow(abs(original), []);
% axis image;
% title('Image reconstruction');

% Recreate an image using random phase
im2 = imread('sar.bmp');
figure;
colormap(gray);
imagesc(im2);
colormap(gray);
randomPhase = random_phase(im2);

%%%%%%%%%%%%%%%%%%%% NOT USED AT THE END %%%%%%%%%%%
% % figure;
% % edges = [0:1:256];
% % h1 = histc(im2, edges);
% % bar(edges, h1, 'k')
% % 
% % figure;
% % edges = [0:1:256];
% % h1 = histc(uint8(real(randomPhase)), edges);
% % bar(edges, h1, 'k')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% % 
% im3 = imread('sar.bmp');
% imshow(im3);
% figure;
% colormap(gray);
% imshow(im3);
% colormap(gray);
% randomMagnitude1 = random_magnitude(im3);
% % 
% im4 = imread('lena.png');
% figure;
% colormap(gray);
% imshow(im4);
% %imagesc(im4);
% colormap(gray);
% randomMagnitude2 = random_magnitude(im4);

%% Experiment 2 - Simple Fourier filtering
im5 = imread('lena.png');
figure;
colormap(gray);
imshow(im5);
%imagesc(im4);
colormap(gray);
figure;
low_out = SimpleFiltering(im5,1,0.1);
imshow(uint8(low_out));

