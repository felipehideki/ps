%% analise da funçao sin(2*pi*10*t)  + sin(2*pi*45*t)
clear;clc;%close all;
% dominio do tempo
fs = 1e4;
t = 0:1/fs:1-1/fs;
st = sin(2*pi*10*t)  + sin(2*pi*75*t);;
pulse = zeros(size(t));

% amostrando o sinal

freq_amostragem = 100;
n = round(fs./freq_amostragem);
pulse(1:n:end) = 1;

sa = pulse.*st;

figure(1)
subplot(3,2,1);plot(t,st);legend('sinal original');xlabel('tempo (s)');
subplot(3,2,3);stem(t,pulse);xlim([0 0.05]);legend('funçao pulso');xlabel('tempo (s)');
subplot(3,2,5);stem(t,sa);xlim([0.3 0.7]);legend('sinal amostrado');xlabel('tempo (s)');
% dominio da frequencia
n = numel(st);
y = fft(st)./n;
y = fftshift(y);

freq = linspace(-0.5,0.5,n)*fs;
subplot(3,2,2);plot(freq,abs(y));xlim([-2*freq_amostragem 2*freq_amostragem]);xlabel('frequencia')
title('dominio da frequencia')
y = fft(pulse)./n;
y = fftshift(y);
subplot(3,2,4);stem(freq,abs(y));xlim([-2*freq_amostragem 2*freq_amostragem]);xlabel('frequencia')
y = fft(sa)./n;
y = fftshift(y);
subplot(3,2,6);plot(freq,abs(y));xlim([-2*freq_amostragem 2*freq_amostragem]);xlabel('frequencia - fs = 100Hz')

figure(2);
y = fft(st)./n;
y = fftshift(y);
freq = linspace(-0.5,0.5,n)*fs;
subplot(2,1,1);plot(freq,abs(y));xlim([-200 200]);xlabel('frequencia')
title('sinal analistico')
y = fft(pulse)./n;
y = fftshift(y);
subplot(2,1,2);stem(freq,abs(y));xlim([-500 500]);xlabel('frequencia')
title('sinal amostrado')
y = fft(sa)./n;
y = fftshift(y);
hold on;plot(freq,2*abs(y));xlim([-200 200]);xlabel('frequencia');hold off


%% convoluindo o sinal do função sinc

clear;clc;%close all;
% dominio do tempo
fs = 1e4;
t = 0:1/fs:1-1/fs;
st = sinc(2*pi*15*(t-0.5));
pulse = zeros(size(t));
% amostrando a o sinal
freq_amostragem = 100;
n = round(fs./freq_amostragem);
pulse(1:n:end) = 1;
sa = pulse.*st;

figure(1)
subplot(3,2,1);plot(t,st);legend('sinal original');xlabel('tempo (s)');
subplot(3,2,3);stem(t,pulse);xlim([0 0.05]);legend('funçao pulso');xlabel('tempo (s)');
subplot(3,2,5);stem(t,sa);xlim([0.3 0.7]);legend('sinal amostrado');xlabel('tempo (s)');
% dominio da frequencia
n = numel(st)
y = fft(st)./n;
y = fftshift(y);
freq = linspace(-0.5,0.5,n)*fs;
subplot(3,2,2);plot(freq,abs(y));xlim([-2*freq_amostragem 2*freq_amostragem]);xlabel('frequencia')
title('dominio da frequencia')
y = fft(pulse)./n;
y = fftshift(y);
subplot(3,2,4);stem(freq,abs(y));xlim([-2*freq_amostragem 2*freq_amostragem]);xlabel('frequencia')
y = fft(sa)./n;
y = fftshift(y);
subplot(3,2,6);plot(freq,abs(y));xlim([-2*freq_amostragem 2*freq_amostragem]);xlabel('frequencia ')

figure(2);
y = fft(st)./n;
y = fftshift(y);
n = numel(y);
freq = linspace(-0.5,0.5,n)*fs;
subplot(2,1,1);plot(freq,abs(y));xlim([-200 200]);xlabel('frequencia')
title('sinal analistico')
y = fft(pulse)./n;
y = fftshift(y);
subplot(2,1,2);stem(freq,abs(y));xlim([-500 500]);xlabel('frequencia')
title('sinal amostrado')
y = fft(sa)./n;
y = fftshift(y);
hold on;plot(freq,20*abs(y));xlim([-200 200]);xlabel('frequencia');hold off
















