function imOut = bilateral2D( imIn, nIt, sigma_r, sigma_d )
% Inputs
%   imIn = input image to apply bilateral filter
%   nIt = number of iterations for the filter
%   sigma_r = value for the weight of normal distribution in value
%   sigma_d = value for the weight of normal distribution in distance
%
% Outputs
%   imOut = filtered image
imIn = double(imIn);
imOut = imIn;
N=round(4*sigma_d);                              % N determines the spatial neighbourhood

%% Generating distance weight - Exponential part of filter related with distances of neighbours 
mask_d = zeros(2*N+1);
for i = 1:2*N+1
    for j = 1:2*N+1
%         mask_d(i,j) = round(abs(i-N+1)+abs(j-N+1));
        mask_d(i,j) = (i-(N+1))^2 + (j-(N+1))^2;
    end
end
weights_d = exp(-mask_d/(2*sigma_d*sigma_d));


[height, width]=size(imIn);

for i = 1:nIt
    for x=1+N:height-N
        for y=1+N:width-N
            patch = imIn(x-N:x+N, y-N:y+N);
            weights = weights_d .* exp(-(patch-imIn(x,y)).*(patch-imIn(x,y))/(2*sigma_r*sigma_r));
            weights = weights./sum(sum(weights));
            imOut(x,y) = sum(sum(weights.*patch));
        end
    end
imIn = imOut;           % Update after each iteration
end
end

