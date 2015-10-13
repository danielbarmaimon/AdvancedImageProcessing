function [ quantized, qLevels ] = quantize( in, levels, cantroids )
%QUANTIZE Summary of this function goes here
%   Detailed explanation goes here

L = length(levels);
[N, M] = size(in);

% quantized image
quantized = double(zeros(N,M));
qLevels = uint8(zeros(N,M));
for i=1:N
   for j=1:M
       % take current pixel
       t = in(i,j);
       % find range to which it belongs
       for k=1:L
          if t < levels(k), break, end; 
       end
       % write the representative point to output image
       quantized(i,j) = cantroids(k);
       qLevels(i,j) = k;
   end
end

end

