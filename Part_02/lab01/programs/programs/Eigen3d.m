function []=Eigen3d(Coef_eigen, No_obj, Para_1);

% ploting the manifold in eigenspace

if Para_1 == 1;
    plot3DEigen(Coef_eigen, No_obj);
    hold off;
else
    surfEigen(Coef_eigen, No_obj, Para_1);
    hold off;
end