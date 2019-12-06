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
subplot(2,1,1);
plot(freqnorm,2*(abs(sigfft).^2),'LineWidth',1.0); % Espectro de energia
xlim([0 1]);
title('Espectro de energia do sinal original');

% % Filtro FIR para frequência normalizada (wc 1633Hz ~ wcn 0.0741)
filtroAA = fir1(1000,0.0741,kaiser(1001,10)); % Janelamento Kaiser
sinal_comAA = conv(sinal_final,filtroAA,'same');
figure(1);
plot(t,sinal_comAA,'r','LineWidth',1.5);
title('Sinal original vs. Sinal com filtro AA');
xlabel('Segundos');
legend('Original','Filtrado');

sinal_comAAfft = fftshift(fft(sinal_comAA));
figure(2);
subplot(2,1,2);
plot(freqnorm,2*(abs(sinal_comAAfft).^2),'r','LineWidth',1.0);
xlim([0 1]);
title('Espectro da energia com filtro AA (pre-downsampled)');
% xlabel('Frequência normalizada');

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

% Kaiser
filtroKaiser1 = fir1(1000,wn1,kaiser(1001,5));
filtroKaiser2 = fir1(1000,wn2,kaiser(1001,5));
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
% freqz(filtroKaiserSoma);

% % Sinal antes, depois e diferença 
figure;
subplot(3,1,1);
plot(tDS,sinalDS);
title('Antes (pré-Hamming)');
subplot(3,1,2);
plot(tDS,sigHamming);
title('Depois (pós-Hamming)');
subplot(3,1,3);
plot(tDS,sinalDS-sigHamming);
title('Diferença (antes - depois)');

figure;
subplot(3,1,1);
plot(tDS,sinalDS);
title('Antes (pré-Kaiser)');
subplot(3,1,2);
plot(tDS,sigKaiser);
title('Depois (pós-Kaiser)');
subplot(3,1,3);
plot(tDS,sinalDS-sigKaiser);
title('Diferença (antes - depois)');

%% Separando o sinal nos intervalos dos quais as teclas foram pressionadas
% Dessa forma, é possível diminuir a intensidade espectral do ruído

% Os "inícios" e "términos" são intervalos de tempo que contém os instantes
% dos quais as teclas foram pressionadas. Esses dados foram obtidos
% empiricamente observando o gráfico no domínio do tempo do sinal filtrado.
inicio = [1.264 1.925 2.7880 3.784 4.613 5.411 6.42 7.05 7.768];
% termino = [1.488 2.232 2.954 3.934 4.782 5.56 6.663 7.216 7.908];

% Determinando as teclagens, do sinal filtrado com janela Kaiser
for i=1:9
   termino(i) = inicio(i)+0.2; % Inicio +0.2 segundos
   intervalo{i} = tDS>=inicio(i) & tDS<=termino(i);
   sinalTeclas{i} = sigKaiser(intervalo{i});
   % Inserção de zeros (zero padding) de 1ªordem para aumento da resolução.
   sinalTeclas{i} = [sinalTeclas{i} zeros(1,numel(sinalTeclas{i}))];
   % Obs.: a inserção de zeros também auxilia no tempo de processamento de
   % algoritmos FFT, pois tais algoritmos são mais eficientes quando o
   % número de amostras é uma potência de 2.
   fftTeclas{i} = fftshift(fft(sinalTeclas{i}));
   freqTeclas{i} = linspace(-fsDS/2,fsDS/2,numel(sinalTeclas{i}));
   figure;
   plot(freqTeclas{i},2*(abs(fftTeclas{i}).^2));   
   xlim([0 fsDS/2]);
   str = sprintf('Teclagem %d', i);
   title(str);
end

%% passa-faixa para encontrar frequências na 2ª e 8ª teclagens
% wnt1 = [697/(fs/2) 1633/(fs/2)]; 
% kaisert1 = fir1(1000,wnt1,kaiser(1001,5));
% sinalTeste = conv(sinal_final, kaisert1,'same');
% 
% inicio = [1.264 1.925 2.7880 3.784 4.613 5.411 6.42 7.05 7.768];
% % termino = [1.488 2.232 2.954 3.934 4.782 5.56 6.663 7.216 7.908];
% 
% for i=1:9
%    termino(i) = inicio(i)+0.3; % Inicio +0.2 segundos
%    intervalo{i} = t>=inicio(i) & t<=termino(i);
%    sinalTeclas{i} = sinalTeste(intervalo{i});
%    % Inserção de zeros (zero padding) de 1ªordem para aumento da resolução.
%    sinalTeclas{i} = [sinalTeclas{i} zeros(1,7*numel(sinalTeclas{i}))];
%    % Obs.: a inserção de zeros também auxilia no tempo de processamento de
%    % algoritmos FFT, pois tais algoritmos são mais eficientes quando o
%    % número de amostras é uma potência de 2.
%    fftTeclas{i} = fftshift(fft(sinalTeclas{i}));
%    freqTeclas{i} = linspace(-fs/2,fs/2,numel(sinalTeclas{i}));
%    figure;
%    plot(freqTeclas{i},2*(abs(fftTeclas{i}).^2));
%    xlim([0 fsDS/2]);
% end
