clear all;
close all;

fs = 500;
t = 0:1/fs:5;

s1 = 2*sin(2*pi*5*t);
s2 = 5*sin(2*pi*10*t);
s3 = 10*sin(2*pi*20*t);

sig = s1+s2+s3;
sigfft = fft(sig);

f = (0:length(sigfft)-1)*fs/length(sigfft);

figure;
plot(f,2*abs(sigfft)/numel(sigfft));
xlim([0 fs/2]);
xlabel('Magnitude');

figure;
plot(f,real(sigfft));
xlim([0 fs/2]);
xlabel('Real');

figure;
plot(f,imag(sigfft));
xlim([0 fs/2]);
xlabel('Imaginário');