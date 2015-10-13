function [seedCoordinates] = setSeed( imLabeled,xMax,yMax)
%SETSEED Function to get the positon of the seed
%
%   This function finds the first pixel labeled as 0. 
%   If it does not finds it returns  -1.
%   It looks from up to down and from left to right
%   
%   Input:
%   -imLabeled : image with labels
%   -xMax :  limit of x
%   -yMax : limit of y
%
%   Output:
%   seedCoordinates :  Coordinates of the seed [x,y] or -1 if it does not found

seedCoordinates = -1;
flagExit = 0;

for j = 1:yMax
    for i = 1:xMax
        % if the position its found get the coordinates and break the function
        if (imLabeled(j,i)==0)
            seedCoordinates = [j, i];
            flagExit = 1;
            break;
        end
    end
    if  (flagExit ==1)
        break;
    end
end

end

