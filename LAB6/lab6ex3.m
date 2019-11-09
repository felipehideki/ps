% % LAB6 Ex.3
clear all
close all

load('som_0.mat');

sig{1} = g1000'; fs{1} = 1000;
sig{2} = g1980'; fs{2} = 1980;
sig{3} = g5000'; fs{3} = 5000;

for i=1:3
    sigfft{i} = fftshift(fft(sig{i}));
    n{i} = numel(sigfft{i});
    freq{i} = linspace(-n{i}/2,n{i}/2,n{i}).*fs{i}/n{i};
    figure;
    plot(freq{i},abs(sigfft{i})/max(abs(sigfft{i})),'LineWidth',1.5);
    xlim([0 fs{i}/2]);
    if i==1
        title('fs = 1000Hz');
    end
    if i==2
        title('fs = 1980Hz');
    end
    if i==3
        title('fs = 5000Hz');
    end
end

% % DISCUSS�O:
% O bot�o 0 do telefone produz um som com duas frequ�ncias: 941Hz e 1336Hz.
% Dessa forma, a taxa de Nyquist para coleta do sinal � igual a
% 2x1336Hz (2 vezes a frequ�ncia m�xima do sinal), i.e., 2672Hz.
% Quando o som � gravado com uma frequ�ncia de amostragem 1000Hz, ocorre o
% fen�meno "aliasing", ou seja, sobreposi��o das bandas de frequ�ncia do
% sinal ap�s a transformada de Fourier, causando distor��es no gr�fico em
% dom�nio da frequ�ncia. O mesmo ocorre com a frequ�ncia de 1980Hz, por�m,
% com esta frequ�ncia de amostragem, a frequ�ncia de Nyquist � igual a
% 1980Hz/2 = 940Hz, ou seja, bem pr�ximo � frequ�ncia de 941Hz do bot�o 0,
% ent�o para essa frequ�ncia h� pouca sobreposi��o e por isso o gr�fico do
% sinal no dom�nio da frequ�ncia resulta em uma frequ�ncia de 941Hz 
% predominante. Com a frequ�ncia de amostragem 5000Hz, a frequ�ncia de
% Nyquist � 5000Hz/2 = 2500Hz, ou seja, bem acima da frequ�ncia m�xima do
% sinal, que � 1336Hz. Dessa forma, � poss�vel coletar todas as frequ�ncias
% do sinal sem causar sobreposi��o de bandas (aliasing) ao realizar a
% transformada de Fourier, resultando em um gr�fico no dom�nio da
% frequ�ncia com duas frequ�ncias predominantes, justamente as de 941Hz e
% 1336Hz.