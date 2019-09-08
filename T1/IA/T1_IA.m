% % T1 IA
clear all;
close all;

load('data_turma-IA.mat');

% % a)
tsinal = y/fs; % Tempo de coleta do sinal = n�mero de amostras/fs

% % b)
[corr_ypulse,lag] = xcorr(y,pulse);
[picos,posicao_pico] = findpeaks(corr_ypulse,'Minpeakheight',150);
num_reflexoes = length(picos); % N�mero de reflex�es = n�mero de picos

% % c)
treflexao = (posicao_pico - (length(lag)/2))/fs; % Eliminando espelhamento
for i=1:num_reflexoes
    profundidade_reflexao(i) = (treflexao(i)/2)*300; % Profundidade em m
end