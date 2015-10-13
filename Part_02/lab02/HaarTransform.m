function [ imOut ] = HaarTransform( im, iter )
    [n,m] = size(im);
    [Wn,Wm] = generateMatrices( n,m );

    B=Wn*double(im)*Wm';
    
    imOut = B;

    if (iter == 1), return; end;    % Check if is the last iteration

    imOut(1:n/2,1:m/2) = HaarTransform(imOut(1:n/2,1:m/2), iter-1); % Recursively get the image
end

