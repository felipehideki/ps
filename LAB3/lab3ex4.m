% % LAB4 Ex.4
clear all;
close all;

alpha = 0.1;
k = 0.05; % com 50s x não dissona
fs = 100;
n = [0:1/fs:2];

x = sin(20*pi*1*n);
xshifted = sin(20*pi*1*(n-k));
y = alpha*xshifted;

[a,lag] = xcorr(x,x);
tlag = (1/fs)*lag;
[c,lag2] = xcorr(y,x); % Correlação não comuta!, xcorr(x,y)!=xcorr(y,x)
tlag2 =(1/fs)*lag2; 
figure;
subplot(2,1,1);
plot(tlag,a);
title('Autocorrelação (x,x)');
xlabel('time lag');
ylabel('xcorr(x,x)');
subplot(2,1,2);
plot(tlag2,c);
title('Correlação (y,x)');
xlabel('time lag');
ylabel('xcorr(y,x)');

% INTERPRETAÇÃO DO RESULTADO:
% A autocorrelação (x,x) retorna um valor de intensidade máxima no tempo de
% deslocamento zero (tlag/fs), como esperado. A correlação (y,x) retorna um
% valor de intensidade dez vezes menor (x0.1), isto é, exatamente o valor
% de amplitude 'alpha' declarado. O tempo de deslocamento tlag/fs na
% intensidade máxima é 0.05, exatamente o valor do shift 'k' declarado.