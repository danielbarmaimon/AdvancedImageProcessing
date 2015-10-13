function [ Wn, Wm ] = generateMatrices( n, m )
%GENERATEMATRICES Summary of this function goes here
%   Detailed explanation goes here
    H = zeros(n/2,n);
    G = zeros(n/2,n);
    % Repeating the each column to generate H, G
    combos = eye(n/2); 
    for i =0:size(combos,1)-1
        H(:,2*i+1) = 1/sqrt(2)*combos(:,i+1);   
        H(:,2*(i+1)) = H(:,2*i+1);
        G(:,2*i+1) = -H(:,2*i+1);  
        G(:,2*(i+1))= H(:,2*i+1);
    end
    Wn = double([H;G]);
    % Repeating the process for dimension m
    H = zeros(m/2,m);
    G = zeros(m/2,m);
    combos = eye(m/2); 
    for i =0:size(combos,1)-1
        H(:,2*i+1) = 1/sqrt(2)*combos(:,i+1); 
        H(:,2*(i+1)) = H(:,2*i+1);
        G(:,2*i+1) = -H(:,2*i+1);  
        G(:,2*(i+1))= H(:,2*i+1);
    end
    Wm = double([H;G]);
end

