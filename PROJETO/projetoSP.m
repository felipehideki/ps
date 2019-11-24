% % PROJETO FINAL - PROCESSAMENTO DE SINAIS - PROF. THIAGO MARTINI

% % ALINE URNA
% % BRUNA SALGADO
% % FELIPE HATANO

close all
clear all

load('dados_02.mat');
%% a) Filtragem por filtro FIR low-pass (wc ~ 1633Hz) e Downsampling

fs = 44100; % Frequência de amostragem dada pelo enunciado
ttotal = numel(sinal_final)/fs; % Tamanho da gravação em segundos
t = 1/fs:1/fs:ttotal;
figure(1);
hold on;
plot(t,sinal_final);

% % Espectro da energia
sigfft = fftshift(fft(sinal_final));
freqnorm = linspace(-1,1,numel(sigfft));
figure(2);
hold on;
plot(freqnorm,2*(abs(sigfft).^2),'LineWidth',1.0); % Espectro de energia
xlim([0 1]);

% % Filtro FIR para frequência normalizada (wc 1633Hz ~ wcn 0.08)
filtroAA = fir1(100,0.08,'low'); 
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
sinalDS = downsample(sinal_comAA',fatorDS);
fsdown = fs/fatorDS;
tDS = (0:1/(fs/fatorDS):ttotal);
figure;
plot(tDS,sinalDS,'LineWidth',1.0);
title('Sinal após filtragem AA e downsampling');
xlabel('Segundos');

%% b)

