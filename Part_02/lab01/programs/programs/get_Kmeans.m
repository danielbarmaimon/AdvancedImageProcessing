%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Method returning mean, std for each class (K class) of an image
%  returns nb_iterations as well
%  
%   [muf, stdf, nb_it,weight]=get_Kmeans(im,K,mask_size,nb_iterations_max,STD)
%
%   im      : matrix containing data of images(im)
%   K       : number of classes to be found in im (must be >= 2) 4 is good value
%   mask_size: [Ml Mc]
%   Ml      : number of lines of each mask (6 is a good value)
%   Mc      : number of rows of each mask  (6 is a good value)
%   nb_iterations_max : number of iterations maximum accepted, 
%                       if algorithm doesn't converge (30 is a quite reasonable value)
%
%   muf     : column vector containing the mean of each class
%             [meanclass1...measnclassK]. 
%             if algorithm doesn't converge muf= mu obtained for the last iteration.
%   stdf    : column vector containing the std of each class
%             [stdclass1..stdclassK]. 
%             If algorithm doesn't converge, stdf = srd obtained for the last iteration.
%
%
%  Default parameters:
%      nb_classes (K) : 4
%      epsilon : 1e-8
%      Mask_size: [8 8]
%      nb_iterations_max: 35
%      STD: 0
%      initmu: []
%      initstd: []
%
%      images class for 225SD2.
%      Yvan Petillot. Last revised : 30/03/99
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [muf, stdf, nb_it,weight] = ...
      get_Kmeans(im,K,mask_size,nb_iterations_max,...
      STD)
   
  epsilon = 1e-8;
  %resizing of im so that the number of lines (resp. number of rows) are
  %a multiple of Ml (resp. Mc)
  
  Ml = mask_size(1);
  Mc = mask_size(2);
  
  nbl = (floor(size(im,1)/Ml)+1)*Ml; %number of lines of work matrix
  nbc = (floor(size(im,2)/Mc)+1)*Mc; %number of rows of work matrix
  Ll  = nbl-size(im,1);              %number of added lines
  Lc  = nbc-size(im,2);              %number of added rows
  Y1=zeros(nbl,nbc);                 %work matrix 
  Y1(1:nbl-Ll,1:nbc-Lc)=im(:,:);
  
  %mirror boundaries to avoid boundary effects
  Y1(1:nbl-Ll,nbc-Lc+1:nbc)=im(1:size(im,1),size(im,2)-Lc+1:size(im,2));
  Y1(nbl-Ll+1:nbl,1:nbc-Lc)=im(size(im,1)-Ll+1:size(im,1),1:size(im,2));
  Y1(nbl-Ll+1:nbl,nbc-Lc+1:nbc)=im(size(im,1)-Ll+1:size(im,1),size(im,2)-Lc+1:size(im,2));
   
  M=nbl*nbc/(Ml*Mc); %nb of masks in work image, integer number
 
%first step of Kmeans algorithm : initilisation
disp('Kmeans processing beginning');
Xk=zeros(M,2); %2=number of extracted characteristics (mean and variance/mask)

k=0;
for k1=1:Mc:nbc  
  for k2=1:Ml:nbl
    k=k+1;
    A = Y1(k2:k2+Ml-1,k1:k1+Mc-1);
    xk=[mean(A(:)) sqrt(cov(A(:)))];  %xk = [mean std] for mask(k2,k1)
    Xk(k,:)=xk;                       %Xk = [mean(1,1) std(1,1)]
                                      %     [mean(2,1) std(2,1)..]
  end
end

%initialisation
Xk_sort=sortrows(Xk,1);
C=zeros(K,2);
C(1,:)=Xk_sort(1,:);
C(K,:)=Xk_sort(M,:);
for k=2:K-1
  C(k,:)=Xk_sort(1+(k-1)*(floor(M/K)+(rem(M,K)~=0)),:);
end

 %find STD / dist=mean+STD*std , STD=E(mean_Xk)/E(std_Xk)

if STD == -1
  moy = mean(Xk);
  STD = moy(1)/moy(2);
end

weight = STD;
%second step of Kmeans algoritm : find the best mean and std for K classes
%C1=zeros(size(C));
C1=ones(size(C));
nb_iterations = 0;

while norm1(C(:,:)-C1(:,:),STD)>epsilon, %to be replaced by a better measure of distance
 
	%while abs(area(C,C1,1)-1) > epsilon, %if clusters are considered as
                                        %rayleigh variables
	C1=C; %C1=C iteration k, C = C iteration k+1
	nb_iterations = nb_iterations+1;


	%break if algorithm doesn't converge after nb_iterations_max iterations
	if nb_iterations > nb_iterations_max 
  		break;
	end


	%----------- centroids association
	for l=1:M %number of masks
 		for i=1:K %number of classes
   		d(i)=norm1(Xk(l,:)-C(i,:),STD); %storing, for each mask, of minimum distance to class i
    		%using of euclidian distance between the considered mask and each class
  		end
  		a=find(min(d)==d);%position of min(d) in d (position1 = class1...)
  		ind(l)=min(a);    %choice of class with minimum number label if
   		               %necessary so that ind= (class1 class4 class2 class3..) 
		  						%for example (ind=(1 4 2 3...))
  								%storing, for each mask, of minimum distance to class i
	end
  
	%----------- centroids calculus
	for i=1:K %number of classes
  		ind1=find(ind==i);
  		if isempty(ind1)
    		C(i,:) = Xk(i,:);
  		else
    		for l=1:length(xk)
      		vect=Xk(:,l);
      		C(i,l)=mean(vect(ind1)); %barycenter if euclidian distance
    		end
  		end
    end
end    

nb_it=nb_iterations;

if nb_iterations <= nb_iterations_max 
  C=sortrows(C,1);
  %clusters means muf=[mu1; mu2; ...muK]
  muf = C(1:K,1);
  %clusters standard deviation stdf=[std1; std2; .. stdK]
  stdf = C(1:K,2);
else
  muf=[];
  stdf=[];
end


function nor = norm1(C,STD)
  
  C(:,2) = STD * C(:,2);
  nor = norm(C);
