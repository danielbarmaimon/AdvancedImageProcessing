function im_out = quantize(im_in, range, level)
 
%% Vibot-8, Sem-3, Heriot Watt University, Edinburgh
% Student Name: Maruf Ahmed Dhali
% Email: mad32@hw.ac.uk, ahmed.062420@gmail.com

%% B31XM – Advanced Image Analysis (Part 2)
% Matlab Lab 2 (B31SE2): Image Compression/Quantization
% Lab date: 21 November 2014
% Submission Deadline: 05 December 2014

%% This function does quantization on input array by given parameters
% Input:    im_in: input array
%           range: range of quantization as [min_value, max_value]
%           level: number of levels in output
%
% Output:   im_out: output after quantization
%

%% Function starts here
% Initialization
max_value = range(2); 
min_value = range(1);
distance = (max_value - min_value)/level;
partition = min_value:distance:max_value;
codebook = min_value:distance:(max_value+distance);

% Call the MATLAB function 'quantiz'
[~, im_out] = quantiz(im_in(:), partition, codebook);
im_out = reshape(im_out, size(im_in,1),size(im_in,2));

end

