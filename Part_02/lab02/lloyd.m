function [ ranges, centroids ] = lloyd( img, nLevels )
%LLOYD Summary of this function goes here
%   Detailed explanation goes here

%% LLOYD

% get sizes
[ N, M ] = size(img);

% generate initial ranges
ranges = double(zeros(1, nLevels));
centroids = double(zeros(1, nLevels));
lowest = min(min(img));
highest = max(max(img));
r = highest - lowest;
for i=1:nLevels
    ranges(i) = uint8(1.0 / nLevels * i * r)+ lowest;
    if i == 1, c = 0; else c = ranges(i-1); end;
    centroids(i) = uint8(c + (ranges(i) - c) / 2);
end


%%%%%%%%%%%%%
%[centroids,ranges] = lloyds(centroids,ranges);
%%%%%%%%%%%%%%%
% % build histogram
% F = uint32(zeros(1, 256));
% % [ q, qLev ] = quantize(img, 1:255, 1:255);
% % for i=1:N
% %    for j=1:M
% %        F(qLev(i,j)) = F(qLev(i,j)) + 1;
% %    end
% % end
% for i=1:N
%    for j=1:M
%        c = img(i,j) + 1;
%        F(c) = F(c) + 1;
%    end
% end
%%%%%%%%%%%%%
%[centroids,ranges] = lloyds(centroids,ranges);
%%%%%%%%%%%%%%%



% % optimize
% for it = 1 : 20
%     %display(strcat('Iteration #', int2str(it)));
%     % for all intervals find new centroids
%     for i=1 : nLevels
%         % integrate current level
%         if i > 1, lowL = ranges(i-1);
%         else lowL = 1; end;
%         highL = ranges(i); S = 0; Sw = 0;
%         % [ lowL, highL ]
%         
%         for j = lowL : highL
%             Sw = Sw + j * F(j);
%             S = S + F(j);
%         end
%         S = uint8(round(Sw / S));
%         %if S < lowL, S = lowL; end;
%         centroids(i) = S;
%     end
%     
%     % for new centroids find new intervals (boundaries)
%     for j = 1 : nLevels-1
%        ranges(j) = uint8(round((centroids(j) + centroids(j+1)) / 2));
%     end
% end

%% LLOYD END

end

