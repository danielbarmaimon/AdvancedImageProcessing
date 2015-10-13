function [ e_d ] = energyDist( imIn )
%ENERGYDIST Summary of this function goes here
%   Returns an array with the cummulative energy for a distribution

y = (sort(abs(imIn(:)),'descend')); % Put all values of the image in array
                                    % in descending order
y_n2 = norm(y,2)^2;                 % Get the norm squared of the array
e_d=zeros(size(y));                 % Pre-allocate the output 
e_d(1) = y(1)^2;                     
for ii=2:size(y,1)
    e_d(ii) = e_d(ii-1) + y(ii)^2;  % For each element calculate the 
end                                 % sum of the squares of the elements
e_d = e_d./y_n2;                    % Normalize the array

end


