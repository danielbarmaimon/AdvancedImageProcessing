%% Function to perform simplified version of anisotropic diffusion
function result = anisotropicDiff(img, numIt, k)
    % Inputs: 
    %    'img' = input image over to perform the filter
    %    'numIt' = integer number of iterations for the algorithm
    %    'k' = constant value to give a bigger or lower weight to the grad
    % Outputs:
    %    'result' = image after applaying the filter
    
    [n,m,~] = size(img);        % Getting the size of the image

    img = double(img)/255;      % Scaling to get image values [0, 1]
    result = img;        % Initialization of the resulting image

    for it=1:numIt
        for i=2:n-1
            for j=2:m-1
                pixel = img(i,j);
                mask = [ exp(-k*(abs(pixel-img(i-1,j-1)))), exp(-k*(abs(pixel-img(i-1,j)))), exp(-k*(abs(pixel-img(i-1,j+1))));
                         exp(-k*(abs(pixel-img(i,j-1)))), exp(-k*(abs(pixel-pixel))), exp(-k*(abs(pixel-img(i,j+1))));
                         exp(-k*(abs(pixel-img(i+1,j-1)))), exp(-k*(abs(pixel-img(i+1,j)))), exp(-k*(abs(pixel-img(i+1,j+1))))];

                window = [img(i-1,j-1), img(i-1,j), img(i-1,j+1);
                          img(i,j-1), pixel, img(i,j+1);
                          img(i+1,j-1), img(i+1,j), img(i+1,j+1)];

                result(i,j) = sum(sum((mask.*window)))/sum(mask(:));

            end  
        end
    fprintf('iteration: %d\n',it)
    img = result;
    end
end