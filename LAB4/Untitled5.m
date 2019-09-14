fs = 1000;
t = 0:1/fs:7;

ruido = 2*randn(size(t));
x1 = 0.7*sin(2*pi*50*t);
x2 = sin(2*pi*120*t);
sig = x1+x2+ruido;

sigfft = fft(sig);
f = (0:length(sigfft)-1)*fs/length(sigfft);

figure;
plot(f,2*abs(sigfft)/numel(sigfft));
xlim([0 fs/2]);
xlabel('Magnitude');