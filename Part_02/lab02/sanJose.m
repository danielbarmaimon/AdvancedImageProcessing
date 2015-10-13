clear
%id = input('Enter your student ID (tower card) number: ');
%rand('state',id)
%randn('state',id)
t = [0:.01:2*pi]; % Times at which to sample the sine function
sig = sin(t)+0.075*randn(1,length(t)); % Original signal, a noisy sine wave
%%
% --------------------------------------------------------------------
%                       UNIFORM QUANTIZER
% --------------------------------------------------------------------
partition = [-3/4:1/4:3/4]; % Length 7, to represent 8 partition intervals (m)
codebook = [-7/8:1/4:7/8]; % Length 8, one representation value per interval (v)
[index,quantized_sig,mse1] = quantiz(sig,partition,codebook); % Quantize.
% Plot original and quantized signals
figure(1)
subplot(2,1,1)
plot(t,sig,t,quantized_sig,'.')
axis tight
xlabel('time');
ylabel('amplitude');
title('8-level uniform quantizer: Orignal and quantized signal')
% Now let us plot the quantization error
subplot(2,1,2)
plot(t,sig-quantized_sig)
axis tight
xlabel('time');
ylabel('amplitude');
title('8-level uniform quantizer: Quantization error')
% --------------------------------------------------------------------
%                       OPTIMUM QUANTIZER
% --------------------------------------------------------------------
% Now design an optimum quantizer using Lloyd's algorithm
new_codebook = [-7/8:1/4:7/8]; % Length 8, one representation value per interval (v)
[partition2,codebook2] = lloyds(sig,new_codebook);
[index2,quantized_sig2,mse2] = quantiz(sig,partition2,codebook2); % Quantize.
% Plot original and quantized signals
figure(2)
subplot(2,1,1)
plot(t,sig,t,quantized_sig2,'.')
axis tight
xlabel('time');
ylabel('amplitude');
title('8-level optimum quantizer: Orignal and quantized signal')
% Now let us plot the quantization error
subplot(2,1,2)
plot(t,sig-quantized_sig2)
axis tight
xlabel('time');
ylabel('amplitude');
title('8-level optimum quantizer: Quantization error')
fprintf('MSE_uniform = %g\n', mse1);
fprintf('MSE_optimum = %g\n', mse2);