%% Loading a sintetic image and showing it in a surf plot
img = double(imread('sintetic3.bmp'))/255.0; % Read the sintetic image
%image = double(image)/255;     % No need to conversion
X = (1:size(img,2));     % Preparing for the creation of the grid
Y = (1:size(img,1));     % Preparing for the creation of the grid
h1=figure('Name', 'Original');
surf(double(X),double(Y),double(img),'FaceColor','interp','EdgeColor','none'); % Plotting the surf
noisy = imnoise(img,'gaussian', 0.075);
h2=figure('Name', 'Gaussian noise sigma = 0.075');
surf(double(X),double(Y),double(noisy),'FaceColor','interp','EdgeColor','none'); % Plotting the surf

%% Applying the filter to the image
%image= double(image)/255;
imOut = bilateral2D(noisy, 1, 8, 10);
h3=figure('Name', 'Image filtered');
surf(double(X),double(Y),double(imOut),'FaceColor','interp','EdgeColor','none'); % Plotting the surf

%% Analysing real images
img = imread('cameraman.tif'); % Read the real image
h4 = figure('Name', 'Cameraman Analysis');
subplot(1,3,1);
imshow(img);
noisy = imnoise(img,'gaussian', 0.00075); % Adding gaussian noise
subplot(1,3,2);
imshow(noisy);
imOut = bilateral2D(noisy, 1, 30, 4);
subplot(1,3,3);
imshow(uint8(imOut));

%% Analysis of variation on sigma_r
img = imread('cameraman.tif'); % Read the real image
noisy = imnoise(img,'gaussian', 0.00075); % Adding gaussian noise
h5 = figure('Name', 'Sigma_r Analysis');
subplot(1,4,1);
imshow(noisy);
subplot(1,4,2);
imOut1 = bilateral2D(noisy, 1, 25, 4);
imshow(uint8(imOut1));
subplot(1,4,3);
imOut2 = bilateral2D(noisy, 1, 75, 4);
imshow(uint8(imOut2));
subplot(1,4,4);
imOut3 = bilateral2D(noisy, 1, 125, 4);
imshow(uint8(imOut3));

%% Analysis of variation of sigma_d
img = imread('lena.png'); % Read the real image
noisy = imnoise(img,'gaussian', 0.00075); % Adding gaussian noise
h6 = figure('Name', 'Sigma_r Analysis');
subplot(1,4,1);
imshow(noisy);
subplot(1,4,2);
imOut4 = bilateral2D(noisy, 1, 75, 4);
imshow(uint8(imOut4));
subplot(1,4,3);
imOut5 = bilateral2D(noisy, 1, 75, 10);
imshow(uint8(imOut5));
subplot(1,4,4);
imOut6 = bilateral2D(noisy, 1, 75, 20);
imshow(uint8(imOut6));

%% Analysis of number of iterations
img = imread('lena.png'); % Read the real image
noisy = imnoise(img,'gaussian', 0.00075); % Adding gaussian noise
h7 = figure('Name', 'Sigma_r Analysis');
subplot(1,4,1);
imshow(noisy);
subplot(1,4,2);
imOut7 = bilateral2D(noisy, 1, 75, 4);
imshow(uint8(imOut7));
subplot(1,4,3);
imOut8 = bilateral2D(noisy, 10, 75, 4);
imshow(uint8(imOut8));
subplot(1,4,4);
imOut9 = bilateral2D(noisy, 20, 75, 4);
imshow(uint8(imOut9));

%% Comparing bilinear vs non-local means
img = imread('cameraman.tif'); % Read the real image
h8 = figure('Name', 'Bilinear vs Non-local means');
subplot(1,3,1);
noisy = imnoise(img,'gaussian', 0.075); % Adding gaussian noise
imshow(noisy);
subplot(1,3,2);
imOut10 = bilateral2D(noisy, 1, 50, 4);
imshow(uint8(imOut10));
subplot(1,3,3);
% Initial implementation of non-local means
%imOut11 = nlmeans(noisy, 9);
% Current implementation of non-local means
imOut11 = FAST_NLM_II(im2double(noisy),5,3,0.15);
imshow(uint8(255*imOut11));

%% Analysis of the noise remaining
h9 = figure('Name', 'Noise remaining');
subplot(1,3,1);
original_noisy = noisy-img; % Adding gaussian noise
imshow(original_noisy);
subplot(1,3,2);
imOut12 = noisy-uint8(imOut10);
imshow(uint8(imOut12));
subplot(1,3,3);
imOut13 = noisy-uint8(255*imOut11);
imshow(uint8(imOut13));