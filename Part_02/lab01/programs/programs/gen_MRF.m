% This functions generates Markov Randon Fields uisng the Potts model
% See F. Tupin, M. Sigelle and H. Maitre
% Definition of a spatial entropy and its use for texture discrimination
% or Y Boykov, O Veksler and R Zabih
% Markov random fields with efficient approximations
% IEEE CVPR, 1998
% Input:
%		image size as an array (ex [32 32]);
%		nb_levels: Number of levels of the random field
% Examples:
%		gen_MRF([32,32],2);
%		gen_MRF([32,32],5);

function a = gen_MRF(size,nb_levels)

% Establish random pattern of grey levels in range
% since fix rounds down towards zero
a = fix(nb_levels*rand(size(1),size(2)));
% Show scaled image
imagesc(a);
% Create initial energy array - all 1's - this creates a very high value
% for the local conditional probability, r, on the first iteration
energ = 100*ones(size(1),size(2));
pause;

% This creates an isotropic mask of Beta's for neighbouring pixels
mask = 1/3*ones(3,3);
% This is an example of another mask
%mask = [ -1/3 1/3 -1/3; 1/3 0 1/3; -1/3 1/3 -1/3];

% Set initial temperature parameter - this will decrease !
T = 1;
cnt = 0;
% 100 iterations - arbitrary
for  i = 1 : 100
   % Apply to every pixel 
   for j = 2 : size(1)-1
      for k = 2 : size(2)-1
        newenerg = 0;
        %new = fix(mean(mean(a(j-1:j+1,k-1:k+1)))/2+nb_levels/2*rand(1,1));
        
        % This ensures that we propose a change of value for the 'new' pixel
        % under consideration - but will it be accepted ?
        finish =0;
        while ~finish 
            new = fix(nb_levels*rand(1,1));
            if (new ~= a(j,k)) finish = 1; end
         end
         
         % Create two arrays of weighted delta functions
         % The first has 1*(mask value) in those locations
         % where the new value is different from the neighbour pixel value
         diff = ((a(j-1:j+1,k-1:k+1)-new)~=0).*mask;
         % The second has 1*(mask_value) in those locations
         % where the new value is the same as theneighbour pixel value
         eq = ((a(j-1:j+1,k-1:k+1)-new)==0).*mask;
         
         % The local energy(potential) is the sum over the neighbourhood
         % of the pairwise clique potentials - here a simple difference of
         % weighted delta functions
         newenerg = sum(sum(diff-eq));
         
         % Next, define the local conditional probability of the MRF
         % using the exponential model
         r = exp(-newenerg)/exp(-energ(j,k));
         % Accept the new value in the image array, and modify energy
         % function if the acceptance criteria is satisfied
         % As T decreases (annealing) so the threshold increases and
         % there is less chance of a change
         
         % Note that r is a function of the negative exponential of the %
         % sum of the clique potentials - the MRF criterion
         if  r > (1-T);
            a(j,k) = new;
            energ(j,k) = newenerg;
          % implicitly else do nothing - leave energy as it is  
         end
      end
   end	
   fprintf('Iteration %d\n',i);
   % Lower temperature
   T = T /log((100+i))*log(100);
   % Every so often, show an image
   if (mod(i,10) == 0)
      imagesc(a(2:size(1)-1,2:size(2)-1))
      pause;
   end	
end	

return;