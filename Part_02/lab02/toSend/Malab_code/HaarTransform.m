function [ imOut ] = HaarTransform( im, iter )
    [n,m] = size(im);
    [Wn,Wm] = generateMatrices( n,m );
    % Get the output image for the first iteration
    B=Wn*double(im)*Wm'; 
    imOut = B; 
    % Check if is the last iteration
    if (iter == 1), return; end;    
    % Recursively get the image
    imOut(1:n/2,1:m/2) = HaarTransform(imOut(1:n/2,1:m/2), iter-1); 
end

