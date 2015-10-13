function [ PSNR, MSE ] = ComputeMetrics( in1, in2)

% computes PSNR and MSE for two provided images

[ N, M ] = size(in1);

MSE = 0;
for i=1:N
   for j=1:M
      c1 = in1(i,j);
      c2 = in2(i,j);
      MSE = MSE + norm(c1 - c2, 2)^2;
   end
end
MSE = MSE / (M * N);
PSNR = 10 * log10( 255^2 / MSE );
% display(strcat('My PSNR: ', num2str(PSNR)));

end

