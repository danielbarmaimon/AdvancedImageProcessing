function [ imOut,numRegions, time ] = regionGrowing(imIn,thresh,conn)
%REGIONGROWING Fuction that segmentates an image by using Region Growing
%
%   Inputs:
%   -imIn   : Name of the input image, the format is not important 
%             e.g: 'imageName.png' 
%   -thresh : Threshold used for the criteria
%   -conn (optional) : Type of connectivity, it can be 8 or 4
%                    	           By default it is 4
%
%   Output:
%   -imOut : Labeled image by regions
%   -numRegions : Number of segmented regions
%   -time  : Execution time
%   -Figure showing the segmented image


%% Read image
tic;                    % Initialization of the clock
img = double(imread(imIn));

%% It's a color image?
checkColor = numel(size(img));
if checkColor == 2
    flagColor = 0;      % The image is a grey scale image
    imLabeled = zeros(size(img));
else
    flagColor = 1;      % The image is a color image
    temp = size(img);
    imLabeled = zeros(temp(1:2));
end

[yMax,xMax] = size(imLabeled);

% Allocating the queue as the the size of the image (static)
queue = zeros(numel(imLabeled),2);

%% Which connectivity?
if (nargin < 3)         % Default
    flagConn = 1;       % It is connectivity 8 by default 
    neighbors = zeros(8,2);
else
    if (conn == 4)
        flagConn = 0;
        neighbors = zeros(4,2);
    elseif (conn == 8)
        flagConn = 1;
        neighbors = zeros(4,2);
    else
        error('The function needs connectivity 4 or 8');
    end
end

%% Algorithm
flagStop = 1;
regionNum = 0;
while flagStop
    %% Putting the seed
%     [seedY, seedX] = find(imLabeled == 0, 1 , 'first'); % Uncomment when using find
    [seedCoordinates] = setSeed( imLabeled,xMax,yMax); % Comment when using find
    seedY = seedCoordinates(1);             % Comment when using find
%     if isempty(seedY)                     % Uncomment when using find
%         flagStop = 0;                     % Uncomment when using find
    if seedY == -1                          % Exit condition % Comment when using find
        flagStop = 0;                       % All pixels are labeled % Comment when using find
    else
       seedX = seedCoordinates(2);          % Comment when using find
       regionNum = regionNum + 1;           % Increasing the region label
       imLabeled(seedY,seedX) = regionNum;  
       queue(1,:) = [seedY,seedX];        				 			  
       counterRegion = 1;       
       counterQueue = 1;

       if flagColor == 1	% Color
       		average = img(seedY,seedX,:);
       else 		% Gray
       		average = img(seedY,seedX);
       end

       currentPosition = 0; 	% Current element in the queue      
       while (currentPosition~=(counterQueue))  	
           currentPosition = currentPosition + 1;
           currentPixel = queue(currentPosition,:);
                      
            %% Getting its neighbors 
            [neighbors] = getNeighbors(currentPixel,flagConn);
           
            %% Checking if the neighbors will be added to the queue
            % It is a queue of seeds therefore it will have only elements that
            % we know they belong to the queue

            % Does the neighbor its inside the image? 
            % Does it has label = 0?
            % Does it fulfilles the criteria?
             for i = 1: numel(neighbors(:,1))
                if (1 <= neighbors(i,2))&&(neighbors(i,2)<= xMax)...
        			&&(1 <= neighbors(i,1))&&(neighbors(i,1)<= yMax)...
        			&&(imLabeled(neighbors(i,1),neighbors(i,2)) == 0)... 
        			&&(checkCriteria(img,neighbors(i,:),average,thresh,flagColor))	%% Check criteria
        			%&&(abs(average-img(neighbors(i,1),neighbors(i,2)))<thresh)		%% Check criteria
                	

        			counterQueue = counterQueue + 1;

        			% Updating the average
        			if flagColor == 1
        				average =  (average*counterRegion+img(neighbors(i,1),neighbors(i,2),:))/...
                    	 		(counterRegion+1);   
    				else
    					average =  (average*counterRegion+img(neighbors(i,1),neighbors(i,2)))/...
                    	 (counterRegion+1);   
					end
        			 
             		counterRegion = counterRegion + 1;
             		% Labeling the neighbor pixel and adding it to the queue
            		imLabeled(neighbors(i,1),neighbors(i,2))= regionNum;
   					queue(counterQueue,:) = neighbors(i,:);

                end
             end
        end             
     end
end  

imOut = imLabeled;
fig = label2rgb(imLabeled);
figure
imshow(fig)
numRegions = regionNum;
time = toc;

end
