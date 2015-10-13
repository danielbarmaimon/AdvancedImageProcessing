% pca_analysis script

x1 = [185 172 171 190 165 178 165 188 160 161 169 180 177 167 177 189 176 163 187 199];
x2 = [80 64 75 90 54 82 89 101 82 65 76 87 77 65 68 72 78 80 76 91];
for i=1:20 x3(i)=x1(i)*0.5+normrnd(0,2); end;
figure, scatter(x2,x1); grid;
xlabel('Weight (Kg)');
ylabel('Height (cm)');
title('Scatter plot of height against weight, weaker covariance');
figure, scatter(x3,x1); grid;
xlabel('Weight (Kg)');
ylabel('Height (cm)');
title('Scatter plot of height against weight, stronger covariance');

% Form data matrices
data2 = [x2' x1'];
meandata2 = mean(data2);
data3 = [x3' x1'];
meandata3 = mean(data3);
% Subtract the mean to get mean adjusted data
ma_data2 = [data2(:,1)-meandata2(1) data2(:,2)-meandata2(2)];
ma_data3 = [data3(:,1)-meandata3(1) data3(:,2)-meandata3(2)];

% Form covariance matrices;
% Note mean is subtracted in covariance computation in any case
C2=covariance(ma_data2);
% same as C2=cov(x2,x1)
C3=covariance(ma_data3);
% same as C3=cov(x3,x1)

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

[V3 D3] = eig(C3);
D3=diag(D3);
% Re-arrange to descending order
[sortD3 indexD3]= sort(D3);
sortD3 = [fliplr(sortD3')]';
indexD3 = [fliplr(indexD3')]';
% Sort eigenvector in corresponding fashion
sortV3 = [];
for i=1:size(indexD3,1) sortV3=[sortV3 V3(:,indexD3(i))]; end;

% Plot mean adjusted data and show eigenvectors
figure, scatter(ma_data2(:,1),ma_data2(:,2),'+'); grid;
xlabel('Weight (Kg)');
ylabel('Height (cm)');
title('Scatter plot of height against weight, weaker covariance');
xax = floor(min(ma_data2(:,1))):ceil(max(ma_data2(:,1)))

for i=1:size(sortV2,2)
    grad = sortV2(2,i)/sortV2(1,i);
    xa1 = min(xax); ya1=grad*xa1;
    xa2 = max(xax); ya2=grad*xa2;
    if (mod(i,2)==0) colour = 'g'; else colour = 'r'; end;
    if (mod(i,2)==0) lw = 2; else lw=4; end;
    line([xa1 xa2],[ya1 ya2],'color',colour,'linewidth',lw);
end;

% Plot mean adjusted data and show eigenvectors
figure, scatter(ma_data3(:,1),ma_data3(:,2),'+'); grid;
xlabel('Weight (Kg)');
ylabel('Height (cm)');
title('Scatter plot of height against weight, stronger covariance');
xax = floor(min(ma_data3(:,1))):ceil(max(ma_data3(:,1)))

for i=1:size(sortV3,2)
    grad = sortV3(2,i)/sortV3(1,i);
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
PCA1data3 = sortV3(:,1)'*ma_data3';
% Expressed as two should be same as before
PCAdata2=sortV2'*ma_data2';
PCAdata3=sortV3'*ma_data3';

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
xlabel('Weight (Kg)');
ylabel('Height (cm)');
title('Compare original + with transformed o data: weaker correlation');

% Now use first component only: because it is an orthogonal matrix
% we use the first column of non-transposed matrix (2 by 1)*(1 by m)
newdata2_1PC = sortV2(:,1)*PCA1data2;
newdata2_1PC = [newdata2_1PC(1,:)+meandata2(1); newdata2_1PC(2,:)+meandata2(2)];
figure, scatter(newdata2_1PC(1,:), newdata2_1PC(2,:),'o'); hold on
scatter(x2,x1,'+'); grid;
xlabel('Weight (Kg)');
ylabel('Height (cm)');
title('Compare original + with transformed o data: one PC ONLY, strong correlation');

% STRONG DATA
% Recreate data using all components: 
% Note, we use the inverse here to make it clear what is going on BUT
% for an orthogonal matrix, the inverse is the transpose, so
% newdata3 = sortV3*PCAdata3 does the same thing
newdata3  = inv(sortV3')*PCAdata3;

newdata3 = [newdata3(1,:)+meandata3(1); newdata3(2,:)+meandata3(2)];
figure, scatter(newdata3(1,:), newdata3(2,:),'o'); hold on
scatter(x3,x1,'+'); grid;
xlabel('Weight (Kg)');
ylabel('Height (cm)');
title('Compare original + with transformed o data: strong correlation');

% Now use first component only: beacuse it is an orthogonal matrix
% we use the first column of non-transposed matrix (2 by 1)*(1 by m)
newdata3_1PC = sortV3(:,1)*PCA1data3;
newdata3_1PC = [newdata3_1PC(1,:)+meandata3(1); newdata3_1PC(2,:)+meandata3(2)];
figure, scatter(newdata3_1PC(1,:), newdata3_1PC(2,:),'o'); hold on
scatter(x3,x1,'+'); grid;
xlabel('Weight (Kg)');
ylabel('Height (cm)');
title('Compare original + with transformed o data: one PC ONLY, strong correlation');

return;







