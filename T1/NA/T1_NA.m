% % T1 NA 
clear all;
close all;

load('eco_US.mat');

% % a)
tsinal = length(eco)/fs; % Tempo de coleta do sinal = número de amostras/fs

% % b)
[corr_ecopulse,lag] = xcorr(eco,pulse);

% % c)
[picos,posicao_pico] = findpeaks(corr_ecopulse,'Minpeakheight',250);
num_reflexoes = length(picos); % Número de reflexões = número de picos

% % d)
treflexao = (posicao_pico - (length(lag)/2))/fs; % Eliminando espelhamento
for i=1:num_reflexoes
    profundidade_reflexao(i) = (treflexao(i)/2)*15.4; % Profundidade em cm
end