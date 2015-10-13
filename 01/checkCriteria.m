function [ flagCriteria ] = checkCriteria(img,pixel,average,thresh,flagColor) 
%CHECKCRITERIA function that checks if a pixel fulfilled a specified criteria
%
%   Input:
%   -img : Image 
%   -pixel : position of the pixel to analize
%   -average :  aveerage value of the region
%   -thresh :  threshold
%   -flagColor : 1 if its a color image and 0 if not (gray)
%
%    Output:
%    flagCriteria : Binary output, 1 if the pixel fulfilles the criteria and 0 otherwise

% The criteria used: Is the difference between the pixel and the average value of the region
% lower than the threshold??  if yes flagCriteria=1  if not flagCriteria=0

flagCriteria = 0;
if flagColor == 1		% Color
	dist = sum(abs(average-img(pixel(1),pixel(2),:)));
	if( dist < thresh)
		flagCriteria = 1;
	end
else 					% Grey Scale
	dist = abs(average-img(pixel(1),pixel(2)));
	if (dist < thresh);
		flagCriteria = 1;
	end
end
end