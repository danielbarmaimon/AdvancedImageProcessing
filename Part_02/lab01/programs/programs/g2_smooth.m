% G2_SMOOTH.M

% function to compute coefficients of first,a simple Gaussian filter,
% second a simple derivative of Gaussian filter,
% of standard deviation, sigma, and window size, window

function [E, F, G] = g2_smooth(window, sigma)

% if even window, add one to make odd, centred on pixel of interest
if rem(window,2) == 0
   window = window + 1; 
end;
   
% set limits of window
high_index = (window-1)/2;
low_index = -high_index;

sum_coefficients = 0; sum_d_coefficients = 0; sum_d2_coefficients = 0;
% compute coefficients
x = low_index:high_index;
for i = 1:window
   smooth(i) = (exp((-x(i)*x(i))/(2*sigma*sigma))/sqrt(2*pi)*sigma);
   d_smooth(i) = (-x(i))*(exp((-x(i)*x(i))/(2*sigma*sigma))/sqrt(2*pi)*sigma*sigma*sigma);
   d2_smooth(i) = (1/(sqrt(2*pi)*sigma*sigma*sigma))*((x(i)*x(i)/(sigma*sigma))-1 )*(exp((-x(i)*x(i))/(2*sigma*sigma)));
   sum_coefficients = sum_coefficients + smooth(i);
   sum_d_coefficients = sum_d_coefficients + abs(d_smooth(i));
   sum_d2_coefficients = sum_d2_coefficients + abs(d2_smooth(i));
   i=i+1;
end;

% Normalise filter coefficients to sum to one
for i = 1:window
   smooth(i) = smooth(i)/sum_coefficients;
   d_smooth(i) = d_smooth(i)/sum_d_coefficients;
   d2_smooth(i) = d2_smooth(i)/sum_d2_coefficients;
end;   

% NOTE: sum of absolute values of all coefficients is 1
E = smooth;
F = d_smooth;
G = d2_smooth;
return;