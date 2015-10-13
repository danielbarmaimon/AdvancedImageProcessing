%% Threshold vs number of regions

regions = [1,20];
regions2 = [1,20];
threshold = (1:13:255);     % 20 values for threshold
time = [1, 20]; 
for i=1:20
   [image,regions(1,i),time(1,i)]=regionGrowing('bomb.jpg',threshold(1,i),4) ;
   [image,regions2(1,i),time(1,i)]=regionGrowing('bomb.jpg',threshold(1,i),8) ;
end
%subplot(2,2,1)
plot(threshold(1,:), regions(1,:), 'b')%,'LineWidth', 1,...
    %'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'b', 'MarkerSize', 5 );
hold on;
plot(threshold(1,:), regions(1,:), 'r')%,'LineWidth', 1,...
    %'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'r', 'MarkerSize', 5 );

% set(gca, 'XTick', 1:10:255);
title('Regions vs Threshold - Bomb')
xlabel('Grey level - 4 (b) and 8 (r) connectivity');
ylabel('Number of regions');
%subplot(2,2,2)
% plot(threshold(1,:), time(1,:), '-o','LineWidth', 3,...
%     'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'b', 'MarkerSize', 10 );
% title('Time vs Threshold - Bomb')
% xlabel('Grey level');
% ylabel('Time(s)');

% for i=1:20
%    [image,regions(1,i),time(1,i)]=regionGrowing('coins.png',threshold(1,i),4) ;
% end
% subplot(2,2,3)
% plot(threshold(1,:), regions(1,:), '-o','LineWidth', 3,...
%     'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'b', 'MarkerSize', 10 );
% plot(threshold(1,:), regions(1,:), '-o','LineWidth', 3,...
%     'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'b', 'MarkerSize', 10 );
% % set(gca, 'XTick', 1:10:255);
% title('Regions vs Threshold - Coins')
% xlabel('Grey level');
% ylabel('Number of regions');
% subplot(2,2,4)
% plot(threshold(1,:), time(1,:), '-o','LineWidth', 3,...
%     'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'b', 'MarkerSize', 10 );
% title('Time vs Threshold - Coins')
% xlabel('Grey level');
% ylabel('Time(s)');
