% % LAB6 Ex.4
fs = 40;
t = 0:1/fs:2;

x1 = cos(20*pi*t); % f1 = 10Hz (2*pi*f*t) = (20*pi*t)
x2 = cos(100*pi*t); % f2 = 50Hz (2*pi*f*t) = (100*pi*t)

% % DISCUSS�O:
% Utilizando a frequ�ncia de amostragem 40Hz, ent�o a frequ�ncia de Nyquist
% � 40Hz/2 = 20Hz. Ou seja, todos os sinais com frequ�ncia m�xima maior que
% 20Hz, causar�o sobreposi��o de bandas de frequ�ncia ("aliasing") ao 
% realizar a transformada de Fourier do sinal.

