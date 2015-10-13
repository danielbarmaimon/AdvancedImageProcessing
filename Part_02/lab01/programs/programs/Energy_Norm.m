function [trainingSet] = Energy_Norm(trainingSet);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Normalizing the total energy of the pixel values of each image to '1'.
%
%   Xun Wang
%   last modified: 13/12/2004
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N= size(trainingSet,2);

for n=1:N
    Indensity(n) = norm(trainingSet(:,n),2);
    if Indensity(n)~=0
        trainingSet(:,n) = trainingSet(:,n)/Indensity(n);
    else
        error('The image cannot be totally black!');
    end
end
