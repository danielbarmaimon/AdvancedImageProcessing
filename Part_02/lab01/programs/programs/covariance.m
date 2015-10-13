% COVARIANCE.M

% Useage: C=cov(x)

% Return the covariance matrix of the data in x, where each column of x
% is one dimension of an n-dimensional data set. That is, x has x columns
% and m rows, and each row is one sample.
%
% For example, if x is three dimensional and there are 4 samples.
% x = [1 2 3;4 5 6;7 8 9;10 11 12]
% c = covariance (x)
function[c] = covariance(x)
% Get the size of the array
sizex=size(x);
% Get the mean of each column
meanx = mean(x);
% For each pair of variables, x1, x2, calculate
% sum ((x1 - meanx1)(x2-meanx2))/(m-1)
for var = 1:sizex(2),
    x1 = x(:,var);
    mx1 = meanx (var);
    for ct = var:sizex (2),
        x2 = x(:,ct);
        mx2 = meanx (ct);
        v = ((x1 - mx1)'* (x2 - mx2))/(sizex(1) - 1);
        cv(var,ct) = v;
        cv(ct,var) = v;
        % do the lower part of c also.
    end,
end,
c=cv;
