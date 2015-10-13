%sparse deblur example
clear all

%generate clean signal
N = 1000;
h = 2*rand(N,1)-1;
htemp = rand(N,1);
h(htemp<.98)=0;

t = 1:N;
h = sin(t/10)'; 

save h h %save this and load to keep using the same clean signal
% load h %22 nonzero entries
figure(42); subplot(5,2,1); plot(0:N-1,h); title('clean signal h'); %plot original clean signal

%generate bluring kernel
X = (1:N)';
sblur = 5; %standard deviation
%wr = 3*sblur; %window radius
g = exp(-( ((X-N/2-1).^2)/(2*sblur^2) )); %Gaussian shifted by N/2 (centered blur kernel)
kc = g; %blur kernel (point spread function) equals Gaussian
%kc = zeros(N,1);
%kc(N/2+1-wr:N/2+1+wr) = g(N/2+1-wr:N/2+1+wr); %blur kernel zero outside window
kc = kc/(sum(sum(kc))); %normalze
subplot(5,2,2); plot(-N/2:N/2-1,kc); title(['Gaussian blur kernel k, \sigma = ' num2str(sblur)']); %plot blur kernel

%convolve h and k using fft
Fk = ((-1).^(X-1)).*fft(kc); %discrete fourier transform of blur kernel ((-1).^(X-1) undoes previous shift)
Fkbar = conj(Fk);
hblur = real(ifft(fft(h).*Fk));
subplot(5,2,3); plot(0:N-1,hblur); title('blurry signal k*h'); %blurry signal

%form mean zero Gaussian noise (different each time script is run)
snoise = .005; %standard deviation
mn = 0;
noise = mn + snoise*randn(N,1);
subplot(5,2,4); plot(0:N-1,noise); title(['mean 0, \sigma = ' num2str(snoise) ', Gaussian noise \eta']); %generated noise

%add noise to blurry signal
hblurnoise = hblur + noise;
subplot(5,2,5); plot(0:N-1,hblurnoise); title('noisy blurry signal f = k*h + \eta'); %noise added to blurry signal

%l2 regularization
lambda = 40; %determine this experimentally
ul2 = real(ifft( lambda*Fkbar.*fft(hblurnoise)./(1+lambda*Fk.*Fkbar) ));
subplot(5,2,6); plot(0:N-1,ul2); title('min 1/2||u||^2 + \lambda ||k*u-f||^2'); %recovered by minimizing l2 regularized function

%l2 of gradient regularization
lam = 2; %determine this experimentally
Flap = exp(-2*pi*i*(0:N-1)'/N) + exp(2*pi*i*(0:N-1)'/N) -2; %symbol of discrete Laplacian
ul2grad = real(ifft( lam*Fkbar.*fft(hblurnoise)./(-Flap+lam*Fk.*Fkbar) ));
subplot(5,2,7); plot(0:N-1,ul2grad); title('min 1/2||grad u||^2 + \lambda ||k*u-f||^2'); %recovered by minimizing l2 of gradient regularized function

%l1 regularization (best)
a = 1; del = 1; %algorithm parameters
ul1_new = zeros(1000,1);
p_new = zeros(1000,1);
p_old = p_new;
its = 2000;
for it = 1:its
   %keep track of previous values
   ul1_old = ul1_new;
   p_older = p_old;
   p_old = p_new;
   %iterate
   ustuff = ul1_old - a*real(ifft(Fkbar.*fft(2*p_old-p_older)));
   ul1_new = ustuff - ustuff./max(abs(ustuff)/a,1);
   pstuff = p_old + del*real(ifft(Fk.*fft(ul1_new)));
   p_new = pstuff - del*(hblurnoise + (pstuff/del-hblurnoise)/(max(norm(pstuff/del-hblurnoise)/(sqrt(N)*snoise),1)));
   
   %keep track of constraint
   %ul1_blur = real(ifft(fft(ul1_new).*Fk));
	%C(it) = abs(sum( (ul1_blur-hblurnoise).^2 ) - N*snoise^2);
end
subplot(5,2,8); plot(0:N-1,ul1_new); title('min ||u||_1 st ||k*u-f||^2 \leq 1000 \sigma^2'); %recovered by minimizing l1 regularized function

subplot(5,2,9); plot(0:N-1,h-ul2); title('error'); %recovered by minimizing l1 regularized function
subplot(5,2,10); plot(0:N-1,h-ul2grad); title('error'); %recovered by minimizing l1 regularized function

% L1 minimization
%  f = hblurnoise;
%  A = kc;
%  mu=10;
%  lambda=1;
%  Niter=10;
%  u=L1_SplitBregmanIteration(g,A,mu,lambda,Niter);
%  figure, plot(u);




