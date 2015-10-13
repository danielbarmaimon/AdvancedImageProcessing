function [no_ind, sm_dist] = nndist(cv,c)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Nearest Neibour Searching
%
%   cv:Coeff. matrix
%   c: Coefficient vector
% 
%   Xun Wang
%   last modified: 13/12/2004
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[r,s] = size(cv); %s: number of points, r: number of eigenvectors
[r2,q] = size(c); %q: 1

d = zeros(s,q);

for i=1:s
  x = cv(1:r2,i)*ones(1,q);
  d(i,:) = sum((x-c).^ 2) .^ 0.5;
end

[dist,indi]=sort(d);

no_ind=indi(1);
sm_dist=dist(1);


