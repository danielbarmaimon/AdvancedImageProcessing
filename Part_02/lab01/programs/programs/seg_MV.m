%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Method returning the segmented image thanks to the ML criterion
%  (statistical segmentation)
%  
%  
%   im_seg = seg_MV(muf,stdf,im,statistical_law)
%
%   im  : matrix to which is applied segmentation (original image or
%         filtered image)
%   muf : column vector of mean of each class in the image im (returned by get_Kmeans)
%   stdf: column vector of std of each class in the image im (returned by
%         get_Kmeans)
%   K   : number of classes
%   statistical_law = 0 : gauss law
%                   = 1 : rayleigh law 
%
%      images class for ARAMIS project.
%      C. Salson. Last revised : 30/03/99
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function im_seg = seg_MV(muf,stdf,im,statistical_law) 

im = double(im);
if nargin~=4
  disp('wrong arguments number');
else  
  K=length(muf);  %number of classes
  if (statistical_law ~= 0) & (statistical_law ~= 1)
    disp('wrong argument for statistical law type');
  else
    if statistical_law == 0 %gauss
      for k2=1:K 
 ...
 p(:,:,k2)=exp(-((im-2*muf(k2)).*(im-2*muf(k2))/(2*stdf(k2)^2)))/stdf(k2); %matrix of density of probability of each class
      end
    elseif statistical_law == 1 %rayleigh
      for k2=1:K
	sigma=muf(k2)*sqrt(2/pi); %the most likely value of density of probability
	p(:,:,k2)=exp(-0.5/(sigma^2)*(im.*im))/(sigma^2);
      end
    end
    t =  p(:,:,1);
    for k2=1:K
      t = max(t,p(:,:,k2)); %matrice des maximums de ddp
    end
    im_seg = zeros(size(im,1),size(im,2));
    for k2=1:K
      seg = (p(:,:,k2) == t);
      im_seg(seg) = muf(k2);
      %im_seg(seg) = im_seg(seg) + muf(k2);
      
    end
  end
end
