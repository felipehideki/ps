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

% % Filtro FIR para frequência normalizada (wc 1633Hz ~ wcn 0.0741)
filtroAA = fir1(1000,0.0741,kaiser(1001,10)); % Janelamento Kaiser
sinal_comAA = conv(sinal_final,filtroAA,'same');
figure(1);
plot(t,sinal_comAA,'r');
title('Sinal com filtro AA (pre-downsampled) vs. Original');
xlabel('Segundos');
legend('Original','Filtrado');

sinal_comAAfft = fftshift(fft(sinal_comAA));
figure(2);
plot(freqnorm,2*(abs(sinal_comAAfft).^2),'r','LineWidth',1.0);
xlim([0 1]);
title('Espectro da energia com filtro AA (pre-downsampled) vs. Original');
xlabel('Frequência normalizada');
legend('Original','Filtrado');

% % Lembrando que o filtro FIR possui fase linear, i.e., causa um atraso
% % de grupo no sinal.

% % Downsampling
fatorDS = floor(fs/(2*1633));
sinalDS = downsample(sinal_comAA,fatorDS);
fsDS = fs/fatorDS;
tDS = (0:1/fsDS:ttotal);
sinalDSfft = fftshift(fft(sinalDS));
freqnormDS = linspace(-1,1,numel(sinalDSfft));
figure(3);
plot(freqnormDS,2*(abs(sinalDSfft).^2),'LineWidth',1.0);
title('Espectro da energia do sinal downsampled');
xlim([0 1]);
xlabel('Frequência normalizada');

%% b) Projetando FIR para remover frequências indesejadas

% % A sinalização DTMF (Dual-Tone Multi-Frequency) produz dois sons: um em
% % frequências entre 697Hz e 941Hz e outro entre as frequências 1209Hz e
% % 1633Hz. Ou seja, janelamentos passa-faixa entre essas frequências é
% % um método eficiente para remover a maior parte das frequências
% % indesejadas.
% % Para realizar uma atenuação de 99.999% das frequências indesejadas, é
% % necessário ajustar a frequência de corte para os filtros projetados tal
% % que o decaimento seja 20*log10(1-0.99999) = -100dB.

% Vetores de frequências normalizadas
wn1 = [697/(fsDS/2) 941/(fsDS/2)]; 
wn2 = [1209/(fsDS/2) 1633/(fsDS/2)];

% Hamming
filtroHamming1 = fir1(1000,wn1,hamming(1001));
filtroHamming2 = fir1(1000,wn2,hamming(1001));
filtroHammingSoma = filtroHamming1 + filtroHamming2;
sigHamming = conv(sinalDS,filtroHammingSoma,'same');
sigHammingfft = fftshift(fft(sigHamming));
figure(4);
subplot(2,1,1);
plot(freqnormDS,2*(abs(sinalDSfft).^2),'LineWidth',1.0);
title('Espectro da energia do sinal downsampled vs. filtrado');
hold on;
plot(freqnormDS,2*(abs(sigHammingfft).^2),'r','LineWidth',1.0);
xlim([0 1]);
xlabel('Frequência normalizada');
legend('Downsampled s/filtro','Hamming');
hold off;
% freqz(filtroHammingSoma);
% plot(tDS,sigHamming);

% Kaiser
filtroKaiser1 = fir1(1000,wn1,kaiser(1001,10));
filtroKaiser2 = fir1(1000,wn2,kaiser(1001,10));
filtroKaiserSoma = filtroKaiser1 + filtroKaiser2;
sigKaiser = conv(sinalDS,filtroKaiserSoma,'same');
sigKaiserfft = fftshift(fft(sigKaiser));
figure(4);
subplot(2,1,2);
plot(freqnormDS,2*(abs(sinalDSfft).^2),'LineWidth',1.0);
hold on;
plot(freqnormDS,2*(abs(sigKaiserfft).^2),'r','LineWidth',1.0);
xlim([0 1]);
xlabel('Frequência normalizada');
legend('Downsampled s/filtro','Kaiser');
hold off;
% plot(tDS,sigKaiser);
% freqz(filtroKaiser1);

%% Separando o sinal nos intervalos dos quais as teclas foram pressionadas
% Dessa forma, é possível diminuir a intensidade espectral do ruído

inicio = [1.347 1.9520 2.7880 3.784 4.613 5.411 6.42 7.09 7.768];
termino = [1.488 2.232 2.954 3.934 4.782 5.56 6.663 7.216 7.908];

for i=1:9
   intervalo{i} = tDS>=inicio(i) & tDS<=termino(i);
   sinalTeclas{i} = sigKaiser(intervalo{i});
   figure;
   freqTeclas{i} = linspace(-fsDS/2,fsDS/2,numel(sinalTeclas{i}));
   plot(freqTeclas{i},abs(fftshift(fft(sinalTeclas{i}))).^2);
   xlim([0 fsDS/2]);
end
