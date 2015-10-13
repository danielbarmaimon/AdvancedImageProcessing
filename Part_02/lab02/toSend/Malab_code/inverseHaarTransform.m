function [ imOut ] = inverseHaarTransform( im, iter )
    [n,m] = size(im);
    % Get the output image for the first iteration
    imOut = im;
    % Check if all iterations have been performed
    if (iter == 0), return; end; 
    imOut(1:n/2,1:m/2) = inverseHaarTransform(imOut(1:n/2,1:m/2), iter-1);
    % Update the matrices after getting the Inverse Wavelet Tranform   
    [Wn,Wm] = generateMatrices( n,m );
    imOut = Wn'*double(imOut)*Wm;
end

