function [ f ] = plot_hist_centers( I,borders,centers )
%PLOT_HIST_CENTERS Summary of this function goes here
%   Detailed explanation goes here
%% Create hist for image
f_min = min(I(:));
f_max = max(I(:));
I_hist_i = f_min:f_max;
I_hist = histc(I(:)',I_hist_i);
I_hist_norm = I_hist/sum(I_hist(:));

f = figure;
plot(I_hist_i,I_hist_norm);
hold on
for ii=1:size(borders,2)
    plot([borders(ii);borders(ii)],[0;max(I_hist_norm)*1.1],'--k');
end

for ii=1:size(centers,2)
    plot([centers(ii);centers(ii)],[0;max(I_hist_norm)*1.1],'r');
end
hold off

end

