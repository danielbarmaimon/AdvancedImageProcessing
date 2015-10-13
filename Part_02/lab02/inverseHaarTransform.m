function [ imOut ] = inverseHaarTransform( im, iter )
    [n,m] = size(im);
    
    imOut = im;
    if (iter == 0), return; end; 
    imOut(1:n/2,1:m/2) = inverseHaarTransform(imOut(1:n/2,1:m/2), iter-1);
       
    [Wn,Wm] = generateMatrices( n,m );
    imOut = Wn'*double(imOut)*Wm;
end

