function mse =  pca_analysis(x1,x2)

% Assumes that x1 and x2 are COLUMN vectors
% Check all data entries are valid



a=~isnan(x1); af = find(a);
b=~isnan(x2); bf = find(b);
iab = intersect(af,bf);

x1 = x1(iab); x2 = x2(iab);

% Form data matrices
data2 = [x2 x1];

figure, scatter(x2,x1); grid;
xlabel('First variable');
ylabel('Second variable');
title('Scatter plot of data in');


meandata2 = mean(data2);
% Subtract the mean to get mean adjusted data
ma_data2 = [data2(:,1)-meandata2(1) data2(:,2)-meandata2(2)];

% Form covariance matrices;
% Note mean is subtracted in covariance computation in any case
C2=covariance(ma_data2);
% same as C2=cov(x2,x1)

% Calculate eigenvalues (D's) and eigenmatrices (V's)
% In eigenmatrices, each column is an eigenvector
[V2 D2] = eig(C2);
D2=diag(D2);
% Re-arrange to descending order
[sortD2 indexD2]= sort(D2);
sortD2 = [fliplr(sortD2')]';
indexD2 = [fliplr(indexD2')]';
% Sort eigenvector in corresponding fashion
sortV2 = [];
for i=1:size(indexD2,1) sortV2=[sortV2 V2(:,indexD2(i))]; end;

% Plot mean adjusted data and show eigenvectors
figure, scatter(ma_data2(:,1),ma_data2(:,2),'+'); grid;
xlabel('First variable');
ylabel('Second variable');
title('Scatter plot of first against second variable');
xax = floor(min(ma_data2(:,1))):ceil(max(ma_data2(:,1)));

for i=1:size(sortV2,2)
    grad = sortV2(2,i)/sortV2(1,i);
    xa1 = min(xax); ya1=grad*xa1;
    xa2 = max(xax); ya2=grad*xa2;
    if (mod(i,2)==0) colour = 'g'; else colour = 'r'; end;
    if (mod(i,2)==0) lw = 2; else lw=4; end;
    line([xa1 xa2],[ya1 ya2],'color',colour,'linewidth',lw);
end;

% Then compress data as function of eigenvectors/PCs only
% Eigenvector matrix is transposed, so each row is an eigenvector
% Adjusted data matrix is transposed so each row is a data vector
PCA1data2 = sortV2(:,1)'*ma_data2';
% Expressed as two should be same as before
PCAdata2=sortV2'*ma_data2';

% NOTE: data now expressed in terms of two eigenvectors

% WEAK DATA
% Recreate data using all components: 
% Note, we use the inverse here to make it clear what is going on BUT
% for an orthogonal matrix, the inverse is the transpose, so
% newdata2 = sortV2*PCAdata2 does the same thing
newdata2  = inv(sortV2')*PCAdata2;

newdata2 = [newdata2(1,:)+meandata2(1); newdata2(2,:)+meandata2(2)];
figure, scatter(newdata2(1,:), newdata2(2,:),'o'); hold on
scatter(x2,x1,'+'); grid;
xlabel('First variable');
ylabel('Second variable');
title('Compare original + with transformed o data');

% Now use first component only: because it is an orthogonal matrix
% we use the first column of non-transposed matrix (2 by 1)*(1 by m)
newdata2_1PC = sortV2(:,1)*PCA1data2;
newdata2_1PC = [newdata2_1PC(1,:)+meandata2(1); newdata2_1PC(2,:)+meandata2(2)];
figure, scatter(newdata2_1PC(1,:), newdata2_1PC(2,:),'o'); hold on
scatter(x2,x1,'+'); grid;
xlabel('First variable');
ylabel('Second variable');
title('Compare original + with transformed o data: one PC ONLY');

% Finally work out mean square error
mse = 0;
for i=1:length(x1)
    mse = mse + sqrt( (newdata2_1PC(1,i)-x2(i))^2 + (newdata2_1PC(2,i)-x1(i))^2 );
end
mse = mse/size(x1,1);

return;