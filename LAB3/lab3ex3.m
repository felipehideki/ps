% % LAB3 Ex.3
clear all;
close all;

fs = 200;
n = [0:(1/fs):1]; % 1s de sinal
x = sin(2*pi*15*n);
xshifted = sin(2*pi*15*(n-0.7)); % x atrasado 0.02s (com 0.2s x não dissona)
y = xshifted + randn(1,length(n));
[c,lag] = xcorr(y,x); % Correlação não comuta!, xcorr(x,y)!=xcorr(y,x)
tlag = (1/fs)*lag;
figure;
subplot(2,1,1);
plot(lag,c);
title('Correlação (y,x)');
xlabel('lag');
ylabel('xcorr(y,x)');
subplot(2,1,2);
plot(tlag,c);
xlabel('time lag');
ylabel('xcorr(y,x)');

% INTERPRETAÇÃO DO RESULTADO:
% Os sinais x e y possuem como base uma senóide de frequência 15Hz (apesar
% de y possuir um ruído gaussiano, a base continua a mesma).
% Portanto, a correlação cruzada entre x e y retornará um valor de
% intensidade máxima no tempo de deslocamento zero (Lembrando que o MATLAB
% utiliza um range duplo para a função xcorr, de -tmax até +tmax, de
% maneira que o tempo de deslocamento será igual a um valor 'lag/fs' na
% intensidade máxima).
% Uma forma simples de interpretar o resultado de lag é lembrar da operação
% matemática de deslocamento de sinais.
% Quando o sinal y está atrasado em relação ao x, a correlação cruzada
% entre x e y, xcorr(x,y), retorna um valor de lag MENOR que zero. Isto é,
% a intensidade máxima é atingida antes do tempo de deslocamento zero (pois
% o sinal y está 'deslocado para o mesmo sentido da operação'.
% Analogamente, a correlação cruzada entre y e x, xcorr(y,x), retorna um
% valor de lag MAIOR que zero, pois o sinal y está 'deslocado para o
% sentido oposto ao da operação'.
% O resultado é inverso para o sinal y adiantado, pela mesma analogia.