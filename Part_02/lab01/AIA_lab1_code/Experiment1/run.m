ima = imread('circuit.tif');   
figure(1);
colormap(gray);
imagesc(ima);

figure(2);
colormap(gray);
ima_out=random_phase(ima);

figure(3);
colormap(gray);
ima_out=random_magnitude(ima);

