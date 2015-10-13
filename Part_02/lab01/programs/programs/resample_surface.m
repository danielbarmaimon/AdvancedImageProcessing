function [WW]=resample_surface(weight,Objects, p1, p2, npts);

%   p1 must be less than p2


Samp = size(weight, 2)/Objects;
dimen = size(weight, 1);
mpts = Samp/npts;
for n = 1:Objects
    for i = 1:dimen
        b(i,:) = weight(i,(1+(n-1)*Samp):(n*Samp));
    end
    
    %     npts = 20;
    k = 2;
    l = 2;
    %     pl = 40;
    q = bsplsurf(b,k,l,npts,mpts,p1,p2,dimen);
    
    pr(:, :, n) = reshape(q,dimen,p1*p2);
    x = pr(1,:,n);
    y = pr(2,:,n);
    z = pr(3,:,n);
end
WW = pr(:, :, 1);
for n = 2:Objects;
    WW = [WW, pr(:, :, n)];
end
