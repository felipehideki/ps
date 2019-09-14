clear all;
close all;

load('som_baleia.mat');

t = [1:length(w)]/fs;

plot(t,w);

sigfft = fft(w);
f = (0:length(sigfft)-1)*fs/length(sigfft);
plot(f,2*abs(sigfft)/numel(sigfft));
xlim([0 fs/2]);

