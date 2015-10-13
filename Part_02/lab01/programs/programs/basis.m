function [n]=basis(c,t,npts,x)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     c        = order of the B-spline basis function
%     npts     = number of defining polygon vertices
%     n[]      = array containing the basis functions
%                n[1] contains the basis function associated with B1 etc.
%     t        = parameter value
%     x[]      = knot vector
%
%   Xun Wang
%   last modified: 13\12\2004
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nplusc = npts + c;

%   calculate the first order basis functions n[i][1]

for i = 1:(nplusc-1)
    if ((t >= x(i)) & (t < x(i+1)))
        temp(i) = 1;
    else
        temp(i) = 0;
    end
end


%  calculate the higher order basis functions 
for k = 2:c
    for i = 1:(nplusc-k)
        if (temp(i) ~= 0)
            d = ((t-x(i)*temp(i))/(x(i+k-1)-x(i)));
        else
            d = 0;
        end
        if (temp(i+1) ~= 0)
            e = (x(i+k)-t)*temp(i+1)/(x(i+k)-x(i+1));
        else
            e = 0;
        end
        temp(i) = d + e;
    end
end

% pick up last point
if (t == x(nplusc))
    temp(npts) = 1;
end

% put in n array
for i = 1:npts
    n(i) = temp(i);
end

