% % LAB6 Ex.5
clear all
close all

[y,fs] = audioread('Toque_icq.mp3');
ttotal = numel(y)/fs;
t = 1/fs:1/fs:ttotal;

sigfft = fftshift(fft(y));
n = numel(sigfft);
freq = linspace(-n/2,n/2,n).*fs/n;
figure;
plot(freq,(abs(sigfft)/max(abs(sigfft))).^2,'LineWidth',1.5);
xlim([0 fs/2]);
title('Espectro de energia original');

% % a) A frequência de Nyquist é 44100Hz/2 = 22050Hz.

% % b) A frequência de amostragem mínima deve ser 2x1800Hz = 3600Hz para
% % preservação de todos os componentes do sinal. Observado empiricamente
% % através do gráfico do espectro de energia.

fatorDS = fs/3600;
yDS = downsample(y,floor(fatorDS));
fsDS = numel(yDS)/ttotal;
tDS = 1/fsDS:1/fsDS:ttotal;
sigfftDS = fftshift(fft(yDS));
nDS = numel(sigfftDS);
freqDS = linspace(-nDS/2,nDS/2,nDS).*fsDS/nDS;
figure;
plot(freqDS,(abs(sigfftDS)/max(abs(sigfftDS))).^2,'LineWidth',1.5);
xlim([0 fsDS/2]);
title('Espectro de energia do sinal downsampled');

% % c) O fatorDS é o fator de divisão para amostragem do sinal. Se o sinal
% % possui fs = 44100Hz e é desejada uma frequência de amostragem de
% % 3600Hz, é necessário então realizar o downsample do sinal com um fator 
% % de aproximadamente 44100/3600 = 12.25; ou seja, realizar uma amostragem
% % do sinal 12.25 vezes menor.
