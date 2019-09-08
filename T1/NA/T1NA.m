% % T1-NA
clear all;
close all;

load('eco_US.mat');

% % a)
tsinal = length(eco)/fs; % Tempo de coleta do sinal = n�mero de amostras/fs

% % b)
[corr_ecopulse,lag] = xcorr(eco,pulse);

% % c)
[reflexoes,amostrareflexao] = findpeaks(corr_ecopulse,'Minpeakheight',250);
num_reflexoes = length(reflexoes); % N�mero de reflex�es = n�mero de picos

% % d)
treflexao = amostrareflexao/fs;
for i=1:4
    profundidade_sinal(i) = (treflexao(i)/2)*15.4; % Profundidade em cm
end