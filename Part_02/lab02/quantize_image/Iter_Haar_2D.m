function [ R ] = Iter_Haar_2D( I,n_iter )
%ITER_HAAR_2D Summary of this function goes here
%   Detailed explanation goes here
end_v = size(I,1);
end_u = size(I,2);
R = double(I);
for ii=1:n_iter
   R(1:end_v,1:end_u) = Haar_2D(R(1:end_v,1:end_u));  
   end_v = end_v/2;
   end_u = end_u/2;
end



end

