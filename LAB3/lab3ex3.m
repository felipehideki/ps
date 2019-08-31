% % LAB3 Ex.3
clear all;
close all;

fs = 200;
n = [0:(1/fs):1]; % 1s de sinal
x = sin(2*pi*15*n);
xshifted = sin(2*pi*15*(n-0.7)); % x atrasado 0.02s (com 0.2s x n�o dissona)
y = xshifted + randn(1,length(n));
[c,lag] = xcorr(y,x); % Correla��o n�o comuta!, xcorr(x,y)!=xcorr(y,x)
tlag = (1/fs)*lag;
figure;
subplot(2,1,1);
plot(lag,c);
title('Correla��o (y,x)');
xlabel('lag');
ylabel('xcorr(y,x)');
subplot(2,1,2);
plot(tlag,c);
xlabel('time lag');
ylabel('xcorr(y,x)');

% INTERPRETA��O DO RESULTADO:
% Os sinais x e y possuem como base uma sen�ide de frequ�ncia 15Hz (apesar
% de y possuir um ru�do gaussiano, a base continua a mesma).
% Portanto, a correla��o cruzada entre x e y retornar� um valor de
% intensidade m�xima no tempo de deslocamento zero (Lembrando que o MATLAB
% utiliza um range duplo para a fun��o xcorr, de -tmax at� +tmax, de
% maneira que o tempo de deslocamento ser� igual a um valor 'lag/fs' na
% intensidade m�xima).
% Uma forma simples de interpretar o resultado de lag � lembrar da opera��o
% matem�tica de deslocamento de sinais.
% Quando o sinal y est� atrasado em rela��o ao x, a correla��o cruzada
% entre x e y, xcorr(x,y), retorna um valor de lag MENOR que zero. Isto �,
% a intensidade m�xima � atingida antes do tempo de deslocamento zero (pois
% o sinal y est� 'deslocado para o mesmo sentido da opera��o'.
% Analogamente, a correla��o cruzada entre y e x, xcorr(y,x), retorna um
% valor de lag MAIOR que zero, pois o sinal y est� 'deslocado para o
% sentido oposto ao da opera��o'.
% O resultado � inverso para o sinal y adiantado, pela mesma analogia.