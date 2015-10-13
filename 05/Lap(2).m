function L = Lap(A)
% form Laplacian matrix from adjacency matrix
L = diag(sum(A))-A;