function [ borders,centers ] = LloydMaxQuantization( I,L )
%LLOYDMAXQUANTIZATION Summary of this function goes here
%   Detailed explanation goes here
I = double(I);
mse_limit = 0.000001;
f_min = min(I(:));
f_max = max(I(:));
% L = 4;
q = ((f_max-f_min)/L);

%% Create hist for image
I_hist_i = f_min:f_max;
I_hist = histc(I(:)',I_hist_i);
I_hist_norm = I_hist/sum(I_hist(:));

%% Naive quantization
borders = [f_min:q:f_max+(0.1*q)];
h = [1/2,-1/2];
d_b = (conv(borders,h,'valid'));
centers = d_b + borders(1:end-1);

% f = figure;
% plot(I_hist_i,I_hist_norm);
% hold on
% for ii=1:size(borders,2)
%     plot([borders(ii);borders(ii)],[0;max(I_hist_norm)*1.1],'k');
% end
% 
% for ii=1:size(centers,2)
%     plot([centers(ii);centers(ii)],[0;max(I_hist_norm)*1.1],'r');
% end
% hold off

% Compute MSE
mse_m = MSE_m(I,borders,centers);
mse = sum(mse_m);
mse_last = mse+1.1*mse_limit;   % Fake just so it goes in at least once
 i_n = 1;
while (abs(mse-mse_last)>mse_limit)
    new_centers = [];
    new_borders = [];
    % Compute new ceters
    for ii=1:size(borders,2)-1
        interval_i = I_hist_i>=borders(ii) & I_hist_i<borders(ii+1);
        if sum(I_hist_norm(interval_i))~=0
            new_centers(ii) = sum(I_hist_norm(interval_i).*I_hist_i(interval_i))/sum(I_hist_norm(interval_i));
        else
            new_centers(ii) = centers(ii);
        end
    end

    % Compute according borders
    new_borders = f_min;
    for ii=1:size(new_centers,2)-1
        new_borders(size(new_borders,2)+1) = (new_centers(ii+1)-new_centers(ii))/2+new_centers(ii);
    end
    new_borders(size(new_borders,2)+1) = f_max;

    borders = new_borders;
    centers = new_centers;

%     nf = figure;
%     plot(I_hist_i,I_hist_norm);

%     figure(nf);
%     hold on
%     for ii=1:size(borders,2)
%         plot([borders(ii);borders(ii)],[0;max(I_hist_norm)*1.1],'k');
%     end
% 
%     for ii=1:size(centers,2)
%         plot([centers(ii);centers(ii)],[0;max(I_hist_norm)*1.1],'r');
%     end
%     hold off

    mse_last = mse;
    mse_m = MSE_m(I,borders,centers);
    mse = sum(mse_m);
    i_n=i_n+1;
end
i_n




end

