close all; clear; clc;
%% sin de 10 Hz resolução 
figure (1)

fs  =1000;
f = [10 10.5]
lag = +30;

t = 0:1/fs:1+lag/fs;
y = sin(2*pi*f(1)*t) + sin(2*pi*f(2)*t);
subplot(3,2,1);plot(t,y);title(['seno de ' num2str(f(1)) ' e ' num2str(f(2)) ' Hz com intervalo 1s'])
x = fftshift(fft(y));xlim([-0.1 1.1])
n = numel(x)
freq = linspace(-n/2,n/2,n).*fs/n;
subplot(3,2,2);stem(freq,abs(x));xlim([0 20]);

t = 0:1/fs:5-lag/fs;
y = sin(2*pi*f(1)*t) + sin(2*pi*f(2)*t);
subplot(3,2,3);plot(t,y);title(['seno de ' num2str(f(1)) ' e ' num2str(f(2)) ' Hz com intervalo 1s'])
x = fftshift(fft(y));xlim([0 5])
n = numel(x)
freq = linspace(-n/2,n/2,n).*fs/n;
subplot(3,2,4);stem(freq,abs(x));xlim([0 20]);

t = 0:1/fs:15-lag/fs;
y = sin(2*pi*f(1)*t) + sin(2*pi*f(2)*t);
subplot(3,2,5);plot(t,y);title(['seno de ' num2str(f(1)) ' e ' num2str(f(2)) ' Hz com intervalo 1s'])
x = fftshift(fft(y));xlim([0 15])
n = numel(x)
freq = linspace(-n/2,n/2,n).*fs/n;
subplot(3,2,6);stem(freq,abs(x));xlim([0 20]);

clear; clc;

%% sin de 10 Hz resolução zero padding
figure (1)

fs = 100;
f =[10 10.5];
psize = 2;
t = 0:1/fs:15-1/fs;

y = sin(2*pi*f(1)*t) + sin(2*pi*f(2)*t);
subplot(3,2,1);plot(t,y);title(['seno de ' num2str(f(1)) ' e ' num2str(f(2)) ' Hz com intervalo 1s'])
x = fftshift(fft(y));
n = numel(x)
freq = linspace(-n/2,n/2,n).*fs/n;
subplot(3,2,2);plot(freq,abs(x));xlim([0 50]);

y = zeros(size(t)); y(t<psize) = 1;
subplot(3,2,3);plot(t,y);title('função caixa')
x = fftshift(fft(y));
n = numel(x)
freq = linspace(-n/2,n/2,n).*fs/n;
subplot(3,2,4);plot(freq,abs(x));xlim([-4 4]);

w = zeros(size(t)); w(t<psize) = 1;
y = ( sin(2*pi*f(1)*t) + sin(2*pi*f(2)*t)).*w;
subplot(3,2,5);plot(t,y);
x = fftshift(fft(y));
n = numel(x)
freq = linspace(-n/2,n/2,n).*fs/n;
subplot(3,2,6);plot(freq,abs(x));xlim([-0 25]);

%% alterando os tempo da coleta do sinal 

figure (1)

fs = 100;
f =[10 10.5];
psize = [1.2 2 9];
t = 0:1/fs:10-1/fs;

y = sin(2*pi*f(1)*t) + sin(2*pi*f(2)*t);


w = zeros(size(t)); w(t<psize(1)) = 1;
y = ( sin(2*pi*f(1)*t) + sin(2*pi*f(2)*t)).*w;
subplot(3,2,1);plot(t,y);
x = fftshift(fft(y));
n = numel(x)
freq = linspace(-n/2,n/2,n).*fs/n;
subplot(3,2,2);plot(freq,abs(x));xlim([-0 25]);

w = zeros(size(t)); w(t<psize(2)) = 1;
y = ( sin(2*pi*f(1)*t) + sin(2*pi*f(2)*t)).*w;
subplot(3,2,3);plot(t,y);
x = fftshift(fft(y));
n = numel(x)
freq = linspace(-n/2,n/2,n).*fs/n;
subplot(3,2,4);plot(freq,abs(x));xlim([-0 25]);


w = zeros(size(t)); w(t<psize(3)) = 1;
y = ( sin(2*pi*f(1)*t) + sin(2*pi*f(2)*t)).*w;
subplot(3,2,5);plot(t,y);
x = fftshift(fft(y));
n = numel(x)
freq = linspace(-n/2,n/2,n).*fs/n;
subplot(3,2,6);plot(freq,abs(x));xlim([-0 25]);

%% tipos de janelamento
figure (1)
fs = 100;
f = [10 0];
psize = 6;
t = 0:1/fs:25-1/fs;


w = zeros(size(t)); w(t<psize) = 1;
ys = ( sin(2*pi*f(1)*t) + sin(2*pi*f(2)*t)).*w;
y = zeros(size(t)); y(t<psize) = ys(t<psize);
subplot(3,2,1);plot(t,y);
title(['quadrado ' num2str(f(1)) 'Hz ' num2str(f(2)) 'Hz'])
y = zeros(size(t)); y(t<psize) = 1;
subplot(3,2,2);plot(t,y);

ys = ( sin(2*pi*f(1)*t) + sin(2*pi*f(2)*t)).*w;
y = zeros(size(t)); y(t<psize) = ys(t<psize).*triang(numel(ys(t<psize)))';
subplot(3,2,3);plot(t,y);
title(['triangular ' num2str(f(1)) 'Hz ' num2str(f(2)) 'Hz'])
x = fftshift(fft(y));xlim([0 t(end)])
y = zeros(size(t)); y(t<psize) = 1.*triang(numel(ys(t<psize)))';
subplot(3,2,4);plot(t,y);

ys = sin(2*pi*10*t);
y = zeros(size(t)); y(t<psize) = ys(t<psize).*hann(numel(ys(t<psize)))';
subplot(3,2,5);plot(t,y,t(t<psize),hann(numel(ys(t<psize)))');
title(['janela hann ' num2str(f(1)) 'Hz ' num2str(f(2)) 'Hz'])
y = zeros(size(t)); y(t<psize) = 1.*hann(numel(ys(t<psize)))';
subplot(3,2,6);plot(t,y);

%% sin de 10 Hz resolução zero padding
figure (1)
fs = 100;
psize = 2;
f = [10 10.5]
t = 0:1/fs:15-1/fs;


w = zeros(size(t)); w(t<psize) = 1;
ys = ( sin(2*pi*f(1)*t) + sin(2*pi*f(2)*t)).*w;
y = zeros(size(t)); y(t<psize) = ys(t<psize);
subplot(4,2,1);plot(t,y);
title(['janela quadrada ' num2str(f(1)) 'Hz ' num2str(f(2)) 'Hz'])
x = fftshift(fft(y));xlim([0 t(end)])
n = numel(x)
freq = linspace(-n/2,n/2,n).*fs/n;
subplot(4,2,2);plot(freq,abs(x));xlim([9 11]);


ys = ( sin(2*pi*f(1)*t) + sin(2*pi*f(2)*t)).*w;
y = zeros(size(t)); y(t<psize) = ys(t<psize).*triang(numel(ys(t<psize)))';
subplot(4,2,3);plot(t,y,t(t<psize),triang(numel(ys(t<psize)))');
title(['triangular '  num2str(f(1)) 'Hz ' num2str(f(2)) 'Hz'])
x = fftshift(fft(y));xlim([0 t(end)])
n = numel(x)
freq = linspace(-n/2,n/2,n).*fs/n;
subplot(4,2,4);plot(freq,abs(x));xlim([9 11]);


ys = ( sin(2*pi*f(1)*t) + sin(2*pi*f(2)*t)).*w;
y = zeros(size(t)); y(t<psize) = ys(t<psize).*hann(numel(ys(t<psize)))';
subplot(4,2,5);plot(t,y,t(t<psize),hann(numel(ys(t<psize)))');
title(['janela hann '  num2str(f(1)) 'Hz ' num2str(f(2)) 'Hz'])
x = fftshift(fft(y));xlim([0 t(end)])
n = numel(x)
freq = linspace(-n/2,n/2,n).*fs/n;
subplot(4,2,6);plot(freq,abs(x));xlim([9 11]);


ys = ( sin(2*pi*f(1)*t) + sin(2*pi*f(2)*t)).*w;
y = zeros(size(t)); y(t<psize) = ys(t<psize).*flattopwin(numel(ys(t<psize)))';
subplot(4,2,7);plot(t,y,t(t<psize),flattopwin(numel(ys(t<psize)))');
title(['janela flattop'  num2str(f(1)) 'Hz ' num2str(f(2)) 'Hz'])
x = fftshift(fft(y));xlim([0 t(end)])
n = numel(x)
freq = linspace(-n/2,n/2,n).*fs/n;
subplot(4,2,8);plot(freq,abs(x));xlim([9 11]);
