function [ c_e ] = cum_dist( I )
%CUM_DIST Summary of this function goes here
%   Detailed explanation goes here
y = (sort(abs(I(:)),'descend'));

y_n2 = norm(y,2)^2;
c_e=zeros(size(y));
c_e(1) = y(1)^2;
for ii=2:size(y,1)
    c_e(ii) = c_e(ii-1) + y(ii)^2;
end
c_e = c_e./y_n2;

% c_e = sum(c_e) / c_e;

end

