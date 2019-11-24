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
% figure(4);
% plot(tDS,sinalDS,'LineWidth',1.0);
% title('Sinal após filtragem AA e downsampling');
% xlabel('Segundos');

sinalDSfft = fftshift(fft(sinalDS));
freqnormDS = linspace(-1,1,numel(sinalDSfft));
figure(3);
hold on;
plot(freqnormDS,2*(abs(sinalDSfft).^2),'LineWidth',1.0);
xlim([0 1]);
title('Espectro da energia do sinal downsampled');
xlabel('Frequência normalizada');

%% b) Projetando FIR para remover frequências indesejadas

% % A sinalização DTMF (Dual-Tone Multi-Frequency) produz sons em
% % frequências entre 697Hz e 1633Hz, ou seja, um janelamento entre essas
% % frequências é um método eficiente para remover a maior parte das
% % frequências indesejadas.
% % Em range normalizado, 697Hz corresponde a 697/(fsdown/2) = 0.1027. 
% % Portanto, uma frequência de corte de 0.1 para a filtragem
% % passa-alta, garantindo que 697Hz esteja seguramente dentro da banda.
% % Da mesma forma, 1633Hz corresponde a aproximadamente 0.9628, então
% % utilizaremos uma frequência de corte de 0.97 para a filtragem
% % passa-baixa.

wn = [0.1 0.97];
filtroHamming = fir1(1000,wn,rectwin(1001));
sigHamming = conv(sinalDS,filtroHamming,'same');
sigHammingfft = fftshift(fft(sigHamming));
figure(3);
plot(freqnormDS,2*(abs(sigHammingfft).^2),'LineWidth',1.0);
xlim([0 1]);
title('Espectro da energia do sinal downsampled filtrado');
xlabel('Frequência normalizada');
legend('Downsampled s/filtro','c/filtro');

