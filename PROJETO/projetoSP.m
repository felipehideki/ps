%% PROJETO FINAL - PROCESSAMENTO DE SINAIS - PROF. THIAGO MARTINI

% % ALINE URNA
% % BRUNA SALGADO
% % FELIPE HATANO

% % a) Filtragem por filtro FIR low-pass (wc ~ 1633Hz) e Downsampling
close all
clear all

load('dados_02.mat');
sinal_final = sinal_final';

fs = 44100; % Frequência de amostragem dada pelo enunciado
ttotal = numel(sinal_final)/fs; % Tamanho da gravação em segundos
t = 1/fs:1/fs:ttotal;
figure(1);
plot(t,sinal_final);
hold on;

% % Espectro da energia
sigfft = fftshift(fft(sinal_final));
freqnorm = linspace(-1,1,numel(sigfft));
figure(2);
plot(freqnorm,2*(abs(sigfft).^2),'LineWidth',1.0); % Espectro de energia
hold on;

% % Filtro FIR para frequência normalizada (wc 1633Hz ~ wcn 0.08)
filtroAA = fir1(100,0.08,'low'); % Janelamento Hamming
sinal_comAA = conv(sinal_final,filtroAA,'same');
figure(1);
plot(t,sinal_comAA);
title('Sinal com filtro AA (pre-downsampled) vs. Original');
xlabel('Segundos');
legend('Original','Filtrado');

sinal_comAAfft = fftshift(fft(sinal_comAA));
figure(2);
plot(freqnorm,2*(abs(sinal_comAAfft).^2),'LineWidth',1.0);
xlim([0 1]);
title('Espectro da energia com filtro AA (pre-downsampled) vs. Original');
xlabel('Frequência normalizada');
legend('Original','Filtrado');

% % Lembrando que o filtro FIR possui fase linear, i.e., causa um atraso
% % de grupo no sinal.

% % Downsampling
fatorDS = floor(fs/(2*1633));
sinalDS = downsample(sinal_comAA,fatorDS);
fsdown = fs/fatorDS;
tDS = (0:1/(fs/fatorDS):ttotal);
sinalDSfft = fftshift(fft(sinalDS));
freqnormDS = linspace(-1,1,numel(sinalDSfft));
figure(3);
plot(freqnormDS,2*(abs(sinalDSfft).^2),'LineWidth',1.0);
title('Espectro da energia do sinal downsampled');
xlim([0 1]);
xlabel('Frequência normalizada');

%% b) Projetando FIR para remover frequências indesejadas

% % A sinalização DTMF (Dual-Tone Multi-Frequency) produz sons em
% % frequências entre 697Hz e 1633Hz, ou seja, um janelamento entre essas
% % frequências é um método eficiente para remover a maior parte das
% % frequências indesejadas.
% % Em range normalizado, 697Hz corresponde a 697/(fsdown/2) = 0.1027. 
% % Da mesma forma, 1633Hz corresponde a aproximadamente 0.9628.
% % Para realizar uma atenuação de 99.999% das frequências indesejadas, é
% % necessário ajustar a frequência de corte para os filtros projetados tal
% % que o decaimento seja 20log(0.00001) = -120dB.

wn = [0.3 0.9];

% Hamming
filtroHamming = fir1(1000,wn,hamming(1001));
sigHamming = conv(sinalDS,filtroHamming,'same');
sigHammingfft = fftshift(fft(sigHamming));
figure(4);
subplot(2,1,1);
plot(freqnormDS,2*(abs(sinalDSfft).^2),'LineWidth',1.0);
title('Espectro da energia do sinal downsampled vs. filtrado');
hold on;
plot(freqnormDS,2*(abs(sigHammingfft).^2),'LineWidth',1.0);
xlim([0 1]);
xlabel('Frequência normalizada');
legend('Downsampled s/filtro','Hamming');
% freqz(filtroHamming);

% Kaiser
filtroKaiser = fir1(1000,wn,kaiser(1001,4));
sigKaiser = conv(sinalDS,filtroKaiser,'same');
sigKaiserfft = fftshift(fft(sigKaiser));
figure(4);
subplot(2,1,2);
plot(freqnormDS,2*(abs(sinalDSfft).^2),'LineWidth',1.0);
hold on;
plot(freqnormDS,2*(abs(sigKaiserfft).^2),'LineWidth',1.0);
xlim([0 1]);
xlabel('Frequência normalizada');
legend('Downsampled s/filtro','Kaiser');
% freqz(filtroKaiser);
