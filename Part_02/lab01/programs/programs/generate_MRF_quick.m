% This functions generates Markov Randon Fields without simulated annealing or Gibbs sampling 
% This is a cruder and faster version of the other prgram but wit no garantee of convergence.
% Input:
%		image size as an array (ex [32 32]);
%		nb_levels: Number of levels of the random field
% Examples:
%		generate_MRF([32,32],2);
%		generate_MRF([32,32],5);

function a = generate_MRF(size,nb_levels)

a = fix(nb_levels*rand(size(1),size(2)));

imagesc(a);
energ = 100*ones(size(1),size(2));
pause;

mask = [
  -1/3 1/3 -1/3;
  1/3 0 1/3;
  -1/3 1/3 -1/3];
T = 1;

cnt = 0;

for  i = 1 : 100
   for j = 2 : size(1)-1
      for k = 2 : size(2)-1
        newenerg = 0;
        new = fix(nb_levels*rand(1,1));
        diff = ((a(j-1:j+1,k-1:k+1)-new)~=0).*mask;
        eq = ((a(j-1:j+1,k-1:k+1)-new)==0).*mask;
        newenerg = sum(sum(diff-eq));
         if (newenerg < energ(j,k))
            a(j,k) = new;
            energ(j,k) = newenerg;
         end
      end
   end	
   i
   if (mod(i,10) == 0)
      imagesc(a(2:size(1)-1,2:size(2)-1))
      pause;
   end	
end	
