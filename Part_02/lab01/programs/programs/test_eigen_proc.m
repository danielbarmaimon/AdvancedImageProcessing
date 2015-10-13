%example of using eigen_proc.m
switch choice_1
    case 1
        load demo_1_1.mat
    case 2
        load demo_2_1.mat
    case 3
        load demo_3_1.mat
end


[Mean_vec, Eigen_vec, Eigen_val, Coef_eigen] = eigen_proc(Train_set, 20);

%   show the mean image of the whole training image set
m(:,:,1) = reshape(Mean_vec(:,1),size(Mean_vec, 1)^(0.5),size(Mean_vec, 1)^(0.5));
figure;
imagesc(m),title('Mean Image'),colormap('gray');

%   show the first 9 eigenimages
figure;
for i = 1:9
    e(:,:,i) = reshape(Eigen_vec(:,i),size(Eigen_vec, 1)^(0.5),size(Eigen_vec, 1)^(0.5));
    subplot(3,3,i);
    imagesc(e(:,:,i)),colormap('gray');
end

%   plot the fist 3d eigenspace

Eigen3d(Coef_eigen, No_obj, Para_1);

choice_2 = input('    Excute Supersampling? [1-yes, 0-no]:   ');

if choice_2== 1
    
    [WW]=resample_surface(Coef_eigen,No_obj, Para_1*2, 2*size(Train_set,2)/Para_1, Para_1);
    
    if Para_1 == 1;
        plot3DEigen(WW, No_obj);
        hold off;
    else
        surfEigen(WW, No_obj, Para_1*2);
        hold off;
    end
end


    

