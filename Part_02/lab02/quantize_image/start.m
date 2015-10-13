I = imread('lena.jpg');
% I = rgb2gray(I);
%% Haar
H = Haar_2D(I);
D = dct2(I);
H_2 = Iter_Haar_2D(I,2);

%% Save haar
% figure;
% imshow(uint8(I));
% print('-depsc','-r300','../Report/images_r/lena');
% f = figure; imshow(uint8(H));
% print('-depsc','-r300','../Report/images_r/haar_lena');
% f = figure; imshow(uint8(H_2));
% print('-depsc','-r300','../Report/images_r/haar_lena_2');

%% Energy distribution
% c_e_I = cum_dist(double(I));
% c_e_1 = cum_dist(H);
% c_e_2 = cum_dist(H_2);

% figure;
% hold on;
% plot(1:size(c_e_I),c_e_I,'g');
% plot(1:size(c_e_1),c_e_1,'r');
% plot(1:size(c_e_2),c_e_2,'b');
% hold off;
% title('Energy distribution for image and Haar transformations');
% legend('Image','HWT - 1 iteration','HWT - 2 iterations');
% pause
% print('-depsc','-r300','../Report/images_r/energ_dist');

% L = 8;
% 
% %% Normal Image
% [n_b,n_c] = NaiveQuantization(I,L);
% [l_b,l_c] = LloydMaxQuantization(I,L);
% 
% I_n = quantize_image(I,n_b,n_c);
% I_l = quantize_image(I,l_b,l_c);
% 
% %% Haar
% [n_b,n_c] = NaiveQuantization(H,L);
% [l_b,l_c] = LloydMaxQuantization(H,L);
% 
% H_n = quantize_image(H,n_b,n_c);
% H_l = quantize_image(H,l_b,l_c);
% 
% I_h_n = Inv_Haar_2D(H_n);
% I_h_l = Inv_Haar_2D(H_l);
% 
% %% DCT
% [n_b,n_c] = NaiveQuantization(D,L);
% [l_b,l_c] = LloydMaxQuantization(D,L);
% 
% D_n = quantize_image(D,n_b,n_c);
% D_l = quantize_image(D,l_b,l_c);
% 
% I_d_n = idct2(D_n);
% I_d_l = idct2(D_l);
% 
% figure;
% imshow(uint8(I_n));
% print('-depsc','-r300',sprintf('../Report/images_r/I_n_L_%d',L));
% 
% figure;
% imshow(uint8(I_l));
% print('-depsc','-r300',sprintf('../Report/images_r/I_l_L_%d',L));
% 
% figure;
% imshow(uint8(I_h_n));
% print('-depsc','-r300',sprintf('../Report/images_r/I_h_n_L_%d',L));
% figure;
% imshow(uint8(I_h_l));
% print('-depsc','-r300',sprintf('../Report/images_r/I_h_l_L_%d',L));
% figure;
% imshow(uint8(I_d_n));
% print('-depsc','-r300',sprintf('../Report/images_r/I_d_n_L_%d',L));
% figure;
% imshow(uint8(I_d_l));
% print('-depsc','-r300',sprintf('../Report/images_r/I_d_l_L_%d',L));


Ls = [4,8,16,32:16:255];
Mse_l=zeros(4,size(Ls,2));
Entr_l = zeros(4,size(Ls,2));
Psnr_l = zeros(4,size(Ls,2));

for ii = 1:size(Ls,2)
    L = Ls(ii);
    [n_b,n_c] = NaiveQuantization(I,L);
    [l_b,l_c] = LloydMaxQuantization(I,L);

    I_n = quantize_image(I,n_b,n_c);
    I_l = quantize_image(I,l_b,l_c);
    Entr_l(1,ii) = entropy(uint8(I_n));
    Entr_l(2,ii) = entropy(uint8(I_l));
    Psnr_l(1,ii) = PSNR(I,I_n);
    Psnr_l(2,ii) = PSNR(I,I_l);
    Mse_l(1,ii) = MSE(I,I_n);
    Mse_l(2,ii) = MSE(I,I_l);
    
    
    
    [n_b,n_c] = NaiveQuantization(H,L);
    [l_b,l_c] = LloydMaxQuantization(H,L);

    H_n = quantize_image(H,n_b,n_c);
    H_l = quantize_image(H,l_b,l_c);
    Entr_l(3,ii) = entropy(uint8(H_n));
    Entr_l(4,ii) = entropy(uint8(H_l));

    I_h_n = Inv_Haar_2D(H_n);
    I_h_l = Inv_Haar_2D(H_l);
    Mse_l(3,ii) = MSE(I,I_h_n);
    Mse_l(4,ii) = MSE(I,I_h_l);
    Psnr_l(3,ii) = PSNR(I,I_h_n);
    Psnr_l(4,ii) = PSNR(I,I_h_l);
    
        [n_b,n_c] = NaiveQuantization(H_2,L);
    [l_b,l_c] = LloydMaxQuantization(H_2,L);

    H_n = quantize_image(H,n_b,n_c);
    H_l = quantize_image(H,l_b,l_c);
    Entr_l(5,ii) = entropy(uint8(H_n));
    Entr_l(6,ii) = entropy(uint8(H_l));

    I_h_n = Inv_Haar_2D(H_n);
    I_h_l = Inv_Haar_2D(H_l);
    Mse_l(5,ii) = MSE(I,I_h_n);
    Mse_l(6,ii) = MSE(I,I_h_l);
    Psnr_l(5,ii) = PSNR(I,I_h_n);
    Psnr_l(6,ii) = PSNR(I,I_h_l);
    
end

figure;
plot(Ls,Psnr_l);
title('PSNR vs. Levels');
legend('Image (naive q.)','Image (Lloyd-Max q.)','HWT (naive q.)','HWT (Lloyd-Max q.)','HWT - 2iter (naive q.)','HWT - 2iter(Lloyd-Max q.)');
pause
print('-depsc','-r300','../Report/images_r/psnr_graph');

figure;
plot(Ls,Mse_l);
title('MSE vs. Levels');
legend('Image (naive q.)','Image (Lloyd-Max q.)','HWT (naive q.)','HWT (Lloyd-Max q.)','HWT - 2iter (naive q.)','HWT - 2iter(Lloyd-Max q.)');
pause
print('-depsc','-r300','../Report/images_r/mse_graph');

figure;
plot(Ls,Entr_l);
title('Entropy vs. Levels');
legend('Image (naive q.)','Image (Lloyd-Max q.)','HWT (naive q.)','HWT (Lloyd-Max q.)','HWT - 2iter (naive q.)','HWT - 2iter(Lloyd-Max q.)');
pause
print('-depsc','-r300','../Report/images_r/Ent_graph');


% [p,c] = lloyds(double(I(:)'),L);

% f = plot_hist_centers(double(I),n_b,n_c);
% figure(f);
% xlim([0 255]);
% print('-depsc','-r300','../Report/images_r/pdf_naive');
% 
% f = plot_hist_centers(double(I),l_b,l_c);
% figure(f);
% xlim([0 255]);
% print('-depsc','-r300','../Report/images_r/pdf_lloyd');
% 
% [p,c] = lloyds(double(H(:)'),L);
% 
% H_f_n = quantize_image(H,n_b,n_c);
% H_f_l = quantize_image(H,l_b,l_c);
% 
% H_f_l_c = quantize_image(H,[min(H(:)),p,max(H(:))],c);
% 
% I_f_n = Inv_Haar_2D(H_f_n);
% I_f_l = Inv_Haar_2D(H_f_l);
% I_f_l_c = Inv_Haar_2D(H_f_l_c);
% 
% MSE(I,I_f_n)
% MSE(I,I_f_l)
% MSE(I,I_f_l_c)

% I_h = Iter_Haar_2D(I,4);
% 
% HH = Inv_Haar_2D(H);
% hh = Inv_Haar_2D(I_h);
% 
% II_HH = Inv_Iter_Haar_2D(H,1);
% II_hh = Inv_Iter_Haar_2D(I_h,4);



% Quantization


