function [q] = bsplsurf(b,k,l,npts,mpts,p1,p2,d)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     b[]         = array containing the polygon net points
%                   b[1] = x-component
%                   b[2] = y-component
%                   b[3] = z-component
%     k           = order in the u direction
%     l           = order in the w direction
%     mbasis[]    = array containing the nonrational basis functions for one value of w 
%     mpts        = the number of polygon vertices in w direction
%     nbasis[]    = array containing the nonrational basis functions for one value of u 
%     npts        = the number of polygon vertices in u direction
%     p1          = number of parametric lines in the u direction
%     p2          = number of parametric lines in the w direction
%     q[]         = array containing the resulting surface
%                   q[1] = x-component
%                   q[2] = y-component
%                   q[3] = z-component
%
%   Xun Wang
%   last modified: 13\12\2004
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nplusc = npts + k;
mplusc = mpts + l;  
x = zeros(nplusc,1);
y = zeros(mplusc,1);
nbasis = zeros(npts,1);
mbasis = zeros(mpts,1);

temp = d*(p1*p2);

q = zeros(d*p1*p2,1);

%       generate the open uniform knot vectors 

x = knot(npts,k);       %  calculate u knot vector 
y = knot(mpts,l);       %  calculate w knot vector 

icount = 1;

%         calculate the points on the \bsp surface 

if p1~=1
    stepu = x(nplusc)/(p1-1);
else
    stepu = 0;
end
stepw = y(mplusc)/(p2-1);
u = 0;

for uinc = 1:p1
    if ((x(nplusc)-u)<5e-6)
        u = x(nplusc);
    end
    % basis function for this value of u
    nbasis = basis(k,u,npts,x);
    w = 0;
    
    for winc = 1:p2
        if ((y(mplusc)-w)<5e-6)
            w = y(mplusc);
        end
        mbasis = basis(l,w,mpts,y);
        for i = 1:npts
            if (nbasis(i)~=0)
                jbas = d*mpts*(i-1); 
                for j = 1:mpts
                    if (mbasis(j) ~= 0)
                        j1 = jbas +d*(j-1) + 1;
                        pbasis = nbasis(i)*mbasis(j);
                        %  calculate surface point 
%                         q(icount) = q(icount)+b(j1)*pbasis;  
%                         q(icount+1) = q(icount+1)+b(j1+1)*pbasis;
%                         q(icount+2) = q(icount+2)+b(j1+2)*pbasis;
                        %disp(['j1, i, j',num2str(j1),' ',num2str(i),' ',num2str(j)]);
                        for m = 1:d
                            q(icount+(m-1)) = q(icount+(m-1)) + b(j1+(m-1))*pbasis;
                        end
                    end
                end
            end
        end
        icount = icount + d;
        w = w + stepw;
    end
    u = u + stepu;
end

                        
              