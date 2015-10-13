function imOut = imageFilter(originalIm, type, parameters)
%% Inputs
    % originalIm = image to be filtered
    % type = kind of kernel used for the filter
            %   I.E.:   'average', hsize
            %           'disk',radius
            %           'gaussian', hsize, sigma
            %           'laplacian', hsize, sigma
            %           'log', hsize, sigme
            %           'motion', numel, theta
            %           'prewitt'
            %           'sobel'
%% Output
    % imOut = image fitered
imOut = zeros(size(originalIm));
if(strcmp(type,'average'))
    if(numel(parameters)==1)
        if (parameters(1) == floor(parameters(1)));
            h = fspecial('average', parameters(1));
            imOut = imfilter(originalIm,h);
        else
            errordlg('Size of the average filter should be positive integer',...
            'Error');
        end
    else
        errordlg('This filter needs the size to be applied', 'Error');
    end
elseif(strcmp(type,'gaussian'))
    if (numel(parameters) == 2)    
        if (parameters(1) == floor(parameters(1)));
                h = fspecial('gaussian', parameters(1), parameters(2));
                imOut = imfilter(originalIm,h);
        else
            errordlg('The gaussian should have a positive integer size',...
           'File Error');
        end
    else
        errordlg('This filter needs the size and sigma to be applied', 'Error');  
    end
elseif(strcmp(type,'motion'))
    if (numel(parameters) == 2)    
        if (parameters(2) == floor(parameters(2)));
                h = fspecial('motion', parameters(1), parameters(2));
                imOut = imfilter(originalIm,h);
        else
            errordlg('Size of the radius should be positive integer',...
           'File Error');
        end
    else
        errordlg('This filter needs the size of radius to be applied', 'Error');  
    end
    elseif(strcmp(type,'disk'))
    if (numel(parameters == 1))    
        if (parameters(1) == floor(parameters(1)));
                h = fspecial('disk', parameters(1));
                imOut = imfilter(originalIm,h);
        else
            errordlg('Size of the radius should be positive integer',...
           'File Error');
        end
    else
        errordlg('This filter needs the size of radius to be applied', 'Error');  
    end

end






%%%%%%%  deconvBlind()