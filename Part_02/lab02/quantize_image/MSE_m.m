function [ mse_m ] = MSE_m( I,borders,centers )
%MSE_M Summary of this function goes here
%   Detailed explanation goes here

%% Create hist for image
f_min = min(I(:));
f_max = max(I(:));
I_hist_i = f_min:f_max;
I_hist = histc(I(:)',I_hist_i);
I_hist_norm = I_hist/sum(I_hist(:));

mse_m=[];
for ii=1:size(borders,2)-1
    interval_i = I_hist_i>=borders(ii) & I_hist_i<borders(ii+1); 
    mse_m(ii) = sum((I_hist_i(interval_i)-centers(ii)).^2.*I_hist_norm(interval_i));
end


end

