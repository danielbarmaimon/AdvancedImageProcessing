Appendix A
Implementation Code
This is code for use in Scilab, a freeware alternative to Matlab. I used this code to
generate all the examples in the text. Apart from the first macro, all the rest were
written by me.
// This macro taken from
// http://www.cs.montana.edu/˜harkin/courses/cs530/scilab/macros/cov.sci
// No alterations made
// Return the covariance matrix of the data in x, where each column of x
// is one dimension of an n-dimensional data set. That is, x has x columns
// and m rows, and each row is one sample.
//
// For example, if x is three dimensional and there are 4 samples.
// x = [1 2 3;4 5 6;7 8 9;10 11 12]
// c = cov (x)
function [c]=cov (x)
// Get the size of the array
sizex=size(x);
// Get the mean of each column
meanx = mean (x, "r");
// For each pair of variables, x1, x2, calculate
// sum ((x1 - meanx1)(x2-meanx2))/(m-1)
for var = 1:sizex(2),
x1 = x(:,var);
mx1 = meanx (var);
for ct = var:sizex (2),
x2 = x(:,ct);
mx2 = meanx (ct);
v = ((x1 - mx1)’ * (x2 - mx2))/(sizex(1) - 1);

cv(var,ct) = v;
cv(ct,var) = v;
// do the lower part of c also.
end,
end,
c=cv;
// This a simple wrapper function to get just the eigenvectors
// since the system call returns 3 matrices
function [x]=justeigs (x)
// This just returns the eigenvectors of the matrix
[a, eig, b] = bdiag(x);
x= eig;
// this function makes the transformation to the eigenspace for PCA
// parameters:
// adjusteddata = mean-adjusted data set
// eigenvectors = SORTED eigenvectors (by eigenvalue)
// dimensions = how many eigenvectors you wish to keep
//
// The first two parameters can come from the result of calling
// PCAprepare on your data.
// The last is up to you.
function [finaldata] = PCAtransform(adjusteddata,eigenvectors,dimensions)
finaleigs = eigenvectors(:,1:dimensions);
prefinaldata = finaleigs’*adjusteddata’;
finaldata = prefinaldata’;
// This function does the preparation for PCA analysis
// It adjusts the data to subtract the mean, finds the covariance matrix,
// and finds normal eigenvectors of that covariance matrix.
// It returns 4 matrices
// meanadjust = the mean-adjust data set
// covmat = the covariance matrix of the data
// eigvalues = the eigenvalues of the covariance matrix, IN SORTED ORDER
// normaleigs = the normalised eigenvectors of the covariance matrix,
// IN SORTED ORDER WITH RESPECT TO
// THEIR EIGENVALUES, for selection for the feature vector.

//
// NOTE: This function cannot handle data sets that have any eigenvalues
// equal to zero. It’s got something to do with the way that scilab treats
// the empty matrix and zeros.
//
function [meanadjusted,covmat,sorteigvalues,sortnormaleigs] = PCAprepare (data)
// Calculates the mean adjusted matrix, only for 2 dimensional data
means = mean(data,"r");
meanadjusted = meanadjust(data);
covmat = cov(meanadjusted);
eigvalues = spec(covmat);
normaleigs = justeigs(covmat);
sorteigvalues = sorteigvectors(eigvalues’,eigvalues’);
sortnormaleigs = sorteigvectors(eigvalues’,normaleigs);
// This removes a specified column from a matrix
// A = the matrix
// n = the column number you wish to remove
function [columnremoved] = removecolumn(A,n)
inputsize = size(A);
numcols = inputsize(2);
temp = A(:,1:(n-1));
for var = 1:(numcols - n)
temp(:,(n+var)-1) = A(:,(n+var));
end,
columnremoved = temp;
// This finds the column number that has the
// highest value in it’s first row.
function [column] = highestvalcolumn(A)
inputsize = size(A);
numcols = inputsize(2);
maxval = A(1,1);
maxcol = 1;
for var = 2:numcols
if A(1,var) > maxval
maxval = A(1,var);
maxcol = var;
end,
end,
column = maxcol

// This sorts a matrix of vectors, based on the values of
// another matrix
//
// values = the list of eigenvalues (1 per column)
// vectors = The list of eigenvectors (1 per column)
//
// NOTE: The values should correspond to the vectors
// so that the value in column x corresponds to the vector
// in column x.
function [sortedvecs] = sorteigvectors(values,vectors)
inputsize = size(values);
numcols = inputsize(2);
highcol = highestvalcolumn(values);
sorted = vectors(:,highcol);
remainvec = removecolumn(vectors,highcol);
remainval = removecolumn(values,highcol);
for var = 2:numcols
highcol = highestvalcolumn(remainval);
sorted(:,var) = remainvec(:,highcol);
remainvec = removecolumn(remainvec,highcol);
remainval = removecolumn(remainval,highcol);
end,
sortedvecs = sorted;
// This takes a set of data, and subtracts
// the column mean from each column.
function [meanadjusted] = meanadjust(Data)
inputsize = size(Data);
numcols = inputsize(2);
means = mean(Data,"r");
tmpmeanadjusted = Data(:,1) - means(:,1);
for var = 2:numcols
tmpmeanadjusted(:,var) = Data(:,var) - means(:,var);
end,
meanadjusted = tmpmeanadjusted
