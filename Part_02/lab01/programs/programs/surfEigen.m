function [] = surfEigen(weight, Objects, p1n);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Purpose:    Plot 3D eigenspace surfaces
%   Input:      weight-------the weights of all images
%                               a 2D matrix (3 by n), n: number of images
%               Objects---------number of training objects
%               p1n--------first parameter of poses of object
%   
% Xun Wang
% 23/06/2003
% last modified:13\12\2004
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%   Extract weights for each object

Samp = size(weight, 2)/Objects;
p2n = Samp/p1n;
c = ones(p1n, p2n+1);
figure,
for n = 1:Objects
    x = weight(1,(1+(n-1)*Samp):(n*Samp));
    y = weight(2,(1+(n-1)*Samp):(n*Samp));
    z = weight(3,(1+(n-1)*Samp):(n*Samp)); 
    
    %   Reorgonize the weights to form 4 nearest neighbors 
    m=1;
    for mx = 1:p1n
        for my = 1:p2n
            x2(mx, my)=x(m);
            y2(mx, my)=y(m);
            z2(mx, my)=z(m);
            m=m+1;
        end
    end
    x1 = [x2,x2(:,1)];
    y1 = [y2,y2(:,1)];
    z1 = [z2,z2(:,1)];
    c1 = 0.8*c;
    surf(x1, y1, z1, c1), hold on
    if (n==1)
        grid on, 
        xlabel('Eigen1')
        ylabel('Eigen2')
        zlabel('Eigen3')
    end
end


