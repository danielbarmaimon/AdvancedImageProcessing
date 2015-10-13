function [x]=knot(n,c);

%     c            = order of the basis function
%     n            = the number of defining polygon vertices
%     x()          = array containing the knot vector

nplusc = n + c;
nplus2 = n + 2;

x(1) = 0;

for i = 2:nplusc
    if ((i>c)&(i<nplus2))
        x(i) = x(i-1) + 1;
    else
        x(i) = x(i-1);
    end
end
