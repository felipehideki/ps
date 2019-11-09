% % LAB6 Ex.4
fs = 40;
t = 0:1/fs:2;

x1 = cos(20*pi*t); % f1 = 10Hz (2*pi*f*t) = (20*pi*t)
x2 = cos(100*pi*t); % f2 = 50Hz (2*pi*f*t) = (100*pi*t)

% % DISCUSSÃO:
% Utilizando a frequência de amostragem 40Hz, então a frequência de Nyquist
% é 40Hz/2 = 20Hz. Ou seja, todos os sinais com frequência máxima maior que
% 20Hz, causarão sobreposição de bandas de frequência ("aliasing") ao 
% realizar a transformada de Fourier do sinal.

