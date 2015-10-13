function [neighbors] = getNeighbors(currentPixel,flagConn)
% GETNEIGHBORS Function to get the neightbors of a pixel
%
%   Input:
%   currentPixel : coordinates of the center pixel
%   flagConn : flag telling the connectivity of the pixels, 
%                       if 0 -> 4 connectivity ;  1 -> 8 connectivity
%
%   Output:
%   neighbors : Matrix conteining the neighbors of the pixel, in clockwise order

% Neighbors defined clockwise

if flagConn == 0       % 4 connectivity               
    conn = 4;
    neighbors = zeros(conn, 2);           
    neighbors(1,:)= currentPixel + [-1 0];
    neighbors(2,:)= currentPixel + [0 1];
    neighbors(3,:)= currentPixel + [1 0];
    neighbors(4,:)= currentPixel + [0 -1];
else 
    conn = 8;               % 8 connectivity  
    neighbors = zeros(conn, 2);
    neighbors(1,:)= currentPixel + [-1 0];
    neighbors(2,:)= currentPixel + [-1 1];
    neighbors(3,:)= currentPixel + [0 1];
    neighbors(4,:)= currentPixel + [1 1];
    neighbors(5,:)= currentPixel + [1 0];
    neighbors(6,:)= currentPixel + [1 -1];
    neighbors(7,:)= currentPixel + [0 -1];
    neighbors(8,:)= currentPixel + [-1 -1];
end

end


