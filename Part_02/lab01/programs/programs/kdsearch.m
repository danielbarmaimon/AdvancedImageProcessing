function [no_ind] = kdsearch(Coef_eigen, Test_eigen);

% kd tree searching 

theta = 0.01;
size_I_f = [1 0];
No_d = size(Test_eigen,1);
mex kdtree_1.c

while (size_I_f(2)<1)
    high = Test_eigen + theta;
    low = Test_eigen - theta;
    clear It_found;
    clear Index_found;
    [It_found, Index_found] = kdtree_1(Coef_eigen(1:No_d, :), low(1:No_d), high(1:No_d));
    size_I_f= size(Index_found);
    theta = theta+0.001;
end

no_ind = Index_found(1);