close all; clear; clc;
%% sin de 10 Hz resolução 
fs  =100;
f = 10
shift = -3/fs
t = 0:1/fs:1-shift;
y = sin(2*pi*f*t);
subplot(3,2,1);plot(t,y);title('seno de 10 Hz com intervalo 1s')
x = fftshift(fft(y));xlim([-0.1 1.1])
n = numel(x)
freq = linspace(-n/2,n/2,n).*fs/n;
subplot(3,2,2);stem(freq,abs(x));xlim([0 n/2]);

t = 0:1/fs:5-shift;
y = sin(2*pi*f*t);
subplot(3,2,3);plot(t,y);title('seno de 10 Hz com intervalo 5')
x = fftshift(fft(y));xlim([0 5])
n = numel(x)
freq = linspace(-n/2,n/2,n).*fs/n;
subplot(3,2,4);stem(freq,abs(x));xlim([0 50]);

t = 0:1/fs:15-shift;
y = sin(2*pi*f*t);
subplot(3,2,5);plot(t,y);title('seno de 10 Hz com intervalo 15s')
x = fftshift(fft(y));xlim([0 15])
n = numel(x)
freq = linspace(-n/2,n/2,n).*fs/n;
subplot(3,2,6);stem(freq,abs(x));xlim([0 50]);

clear; clc;

%% sin de 10 Hz resolução zero padding
figure (3)
fs = 100;
f =7.5;
t = 0:1/fs:15-1/fs;
y = sin(2*pi*f*t);
subplot(3,2,1);plot(t,y);title('seno de 10 Hz com intervalo 15s')
x = fftshift(fft(y));xlim([-0 15])
n = numel(x)
freq = linspace(-n/2,n/2,n).*fs/n;
subplot(3,2,2);stem(freq,abs(x));xlim([0 50]);

t = 0:1/fs:15-1/fs;
y = zeros(size(t)); y(t<1) = 1;
subplot(3,2,3);plot(t,y);title('funçao caixa')
x = fftshift(fft(y));xlim([0 5])
n = numel(x)
freq = linspace(-n/2,n/2,n).*fs/n;
subplot(3,2,4);plot(freq,abs(x));xlim([-4 4]);

t = 0:1/fs:15-1/fs;
w = zeros(size(t)); w(t<1.5) = 1;
y = sin(2*pi*f*t).*w;
subplot(3,2,5);plot(t,y);title('seno de 10 Hz com intervalo 15s')
x = fftshift(fft(y));xlim([0 15])
n = numel(x)
freq = linspace(-n/2,n/2,n).*fs/n;
subplot(3,2,6);plot(freq,abs(x));xlim([5 15]);

%% sin de 10 Hz resolução zero padding em varios configs
figure (4)
fs = 100;
f = 7.5
t = 0:1/fs:15-1/fs;
w = zeros(size(t)); w(t<1.5) = 1;
y = sin(2*pi*f*t).*w;
subplot(3,2,1);plot(t,y);
x = fftshift(fft(y));xlim([0 t(end)])
n = numel(x)
freq = linspace(-n/2,n/2,n).*fs/n;
subplot(3,2,2);plot(freq,abs(x));xlim([6 9]);

t = 0:1/fs:25-1/fs;
w = zeros(size(t)); w(t<3.5) = 1;
y = sin(2*pi*f*t).*w;
subplot(3,2,3);plot(t,y);
x = fftshift(fft(y));xlim([0 t(end)])
n = numel(x)
freq = linspace(-n/2,n/2,n).*fs/n;
subplot(3,2,4);plot(freq,abs(x));xlim([6 9]);

t = 0:1/fs:35-1/fs;
w = zeros(size(t)); w(t<6.5) = 1;
y = sin(2*pi*f*t).*w;
subplot(3,2,5);plot(t,y);title('seno de 10 Hz com intervalo 15s')
x = fftshift(fft(y));xlim([0 t(end)])
n = numel(x)
freq = linspace(-n/2,n/2,n).*fs/n;
subplot(3,2,6);plot(freq,abs(x));xlim([6 9]);

%% tipos de janelamento
figure (6)
fs = 100;
f = 10;
t = 0:1/fs:25-1/fs;
ys = sin(2*pi*f*t);
y = zeros(size(t)); y(t<3) = ys(t<3);
subplot(3,2,1);plot(t,y);title('quadrado')
y = zeros(size(t)); y(t<3) = 1;

subplot(3,2,2);plot(t,y);


t = 0:1/fs:25-1/fs;
ys = sin(2*pi*f*t);
y = zeros(size(t)); y(t<3) = ys(t<3).*triang(numel(ys(t<3)))';
subplot(3,2,3);plot(t,y);title('triangular')
x = fftshift(fft(y));xlim([0 t(end)])
y = zeros(size(t)); y(t<3) = 1.*triang(numel(ys(t<3)))';
subplot(3,2,4);plot(t,y);


t = 0:1/fs:25-1/fs;
ys = sin(2*pi*10*t);
y = zeros(size(t)); y(t<3) = ys(t<3).*hann(numel(ys(t<3)))';
subplot(3,2,5);plot(t,y,t(t<3),hann(numel(ys(t<3)))');title('janela hann')
y = zeros(size(t)); y(t<3) = 1.*hann(numel(ys(t<3)))';
subplot(3,2,6);plot(t,y);

%% sin de 10 Hz resolução zero padding
figure (7)
fs = 100;
f = 7.5
t = 0:1/fs:25-1/fs;
ys = sin(2*pi*f*t);
y = zeros(size(t)); y(t<3) = ys(t<3);
subplot(3,2,1);plot(t,y);title('janela quadrada')
x = fftshift(fft(y));xlim([0 t(end)])
n = numel(x)
freq = linspace(-n/2,n/2,n).*fs/n;
subplot(3,2,2);plot(freq,abs(x));xlim([6 9]);


t = 0:1/fs:25-1/fs;
ys = sin(2*pi*f*t);
y = zeros(size(t)); y(t<3) = ys(t<3).*triang(numel(ys(t<3)))';
subplot(3,2,3);plot(t,y);title('triangular')
x = fftshift(fft(y));xlim([0 t(end)])
n = numel(x)
freq = linspace(-n/2,n/2,n).*fs/n;
subplot(3,2,4);plot(freq,abs(x));xlim([6 9]);


t = 0:1/fs:25-1/fs;
ys = sin(2*pi*f*t);
y = zeros(size(t)); y(t<3) = ys(t<3).*hann(numel(ys(t<3)))';
subplot(3,2,5);plot(t,y,t(t<3),hann(numel(ys(t<3)))');title('janela hann')
x = fftshift(fft(y));xlim([0 t(end)])
n = numel(x)
freq = linspace(-n/2,n/2,n).*fs/n;
subplot(3,2,6);plot(freq,abs(x));xlim([6 9]);
