%example of uisng eigen_recog.m


switch choice_3
    case 1
        [obj, pos] = eigen_recog('demo_1_2.mat', Test_im, 4);
        load demo_1_1.mat;
    case 2
        [obj, pos] = eigen_recog('demo_2_2.mat', Test_im, 4);
        load demo_2_1.mat;
end

figure;

siz = size(Test_im, 1)^(0.5);
t_ima = reshape(Test_im,siz,siz);
subplot(2,1,1), imagesc(t_ima), title('test image'),colormap('gray');

No_sample = size(Train_set,2)/No_obj;
r_ima = reshape(Train_set(:,(obj-1)*No_sample+pos),siz,siz);
subplot(2,1,2), imagesc(r_ima), title('recognised image'),colormap('gray');



