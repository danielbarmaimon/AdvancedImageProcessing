function [obj, pose]=eigen_recog(E_space, Test_im, No_pca)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   To identify the test image
%
%   E_space: the .MAT file stores the trainingset information
%   Test_im: the input image
%   No_pca: the number of eigenvectors going to be used 
%   
%   obj: object number
%   pose: pose number
%
%   Xun Wang
%   last modified: 13/12/2004
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load(E_space);
%   Test_im = Energy_Norm(Test_im);

Test_im = Test_im-Mean_vec;

Test_eigen = Eigen_vec(:,1:No_pca)'*Test_im;

[no_ind, sm_dist] = nndist(Coef_eigen,Test_eigen);

[no_ind] = kdsearch(Coef_eigen, Test_eigen);

No_sample = size(Coef_eigen,2)/No_obj;
obj = ceil(no_ind/No_sample);
pose = no_ind-(obj-1)*No_sample;

%   plot the recognition in 3D eigenspace
plot3DEigen(Coef_eigen, No_obj);
plot3(Test_eigen(1), Test_eigen(2), Test_eigen(3), 'ko'), hold on
plot3(Coef_eigen(1,no_ind), Coef_eigen(2,no_ind), Coef_eigen(3,no_ind), 'k^'), 
if No_pca==1
    legend('whole dataset','test image','recognized image'),
end
hold off;


