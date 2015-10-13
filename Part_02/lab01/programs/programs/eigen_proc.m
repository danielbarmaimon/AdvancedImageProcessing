function [Mean_vec, Eigen_vec, Eigen_val, Coef_eigen] = eigen_proc(Train_set, No_pc);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   To calculate difference image vectors, mean image vector, eigenvectors
% 
%   Train_set: Training images(each image is in a vector form);
%   No_pc: Number of Priciple Compoments (eigenvectors);
%
%   Mean_vec: Mean-image vector;
%   Eigen_vec: Eigenvectors(principle components);
%   Eigen_val: Eigenvalues;
%   Coef_eigen: coefficients of each image vector in eigenspace.
%
%   Xun Wang
%   last modified: 13/12/2004
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


[M,N] = size(Train_set);

disp('Normalizing original images...');
%   Train_set = Energy_Norm(Train_set);

disp(['Calculating the eigenvectors and eigenvalues using svd...']);

Mean_vec = mean(Train_set,2);

for i=1:N
    Dif_vec(:,i) = Train_set(:,i) - Mean_vec;
end

clear Train_set;

[u,s,v] = svd(Dif_vec,0);
Eigen_vec = u(:,1:No_pc);

Eigen_val = diag(s).^2/(M-1);

disp(['Calculating the Coefficients in eigenspace ...']);

for i = 1:N
    for j = 1:(No_pc)
        Coef_eigen(j,i) = Eigen_vec(:,j)'*Dif_vec(:,i);
    end
end



