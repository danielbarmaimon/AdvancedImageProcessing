%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%
% Image inversion
%
%       ima_out = invert(ima)
%
% This function inverts the input image
%     
%       ima : real input image
%       ima_out : output real
%                
%
% Yvan Petillot, December 2000                                  
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ima_out = invert(ima)
  
  % First convert ima to double
  ima = double(ima);
  % Checks that ima is a gray level image
  if ndims(ima) > 2
    % RGB image?
    if ndims(ima) == 3
      ima = double(rgbtogray(uint8(ima)));
    else
      display('Strange format, Cannot guarantee result');
    end
  end
  % Create new figure
  figure(1)
  % Display ima
  imagesc(ima);
  axis image;
  colormap(gray);
  % Rescales ima between [0, 255]
  mini = min(min(ima));
  maxi = max(max(ima));
  ima_out = (ima-mini)/(maxi-mini)*255;
  % Invert ima_out
  ima_out = 255-ima_out;
  % Display result
  % Create new figure
  figure(2)
  imagesc(ima_out);
  axis image;
  colormap(gray);
  
  
  