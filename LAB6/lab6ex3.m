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

% % DISCUSSÃO:
% O botão 0 do telefone produz um som com duas frequências: 941Hz e 1336Hz.
% Dessa forma, a taxa de Nyquist para coleta do sinal é igual a
% 2x1336Hz (2 vezes a frequência máxima do sinal), i.e., 2672Hz.
% Quando o som é gravado com uma frequência de amostragem 1000Hz, ocorre o
% fenômeno "aliasing", ou seja, sobreposição das bandas de frequência do
% sinal após a transformada de Fourier, causando distorções no gráfico em
% domínio da frequência. O mesmo ocorre com a frequência de 1980Hz, porém,
% com esta frequência de amostragem, a frequência de Nyquist é igual a
% 1980Hz/2 = 940Hz, ou seja, bem próximo à frequência de 941Hz do botão 0,
% então para essa frequência há pouca sobreposição e por isso o gráfico do
% sinal no domínio da frequência resulta em uma frequência de 941Hz 
% predominante. Com a frequência de amostragem 5000Hz, a frequência de
% Nyquist é 5000Hz/2 = 2500Hz, ou seja, bem acima da frequência máxima do
% sinal, que é 1336Hz. Dessa forma, é possível coletar todas as frequências
% do sinal sem causar sobreposição de bandas (aliasing) ao realizar a
% transformada de Fourier, resultando em um gráfico no domínio da
% frequência com duas frequências predominantes, justamente as de 941Hz e
% 1336Hz.