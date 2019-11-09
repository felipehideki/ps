close all
fs = 200;
t = 0:1/fs:2;
y = sin(2*pi*40*t) + sin(2*pi*60*t);
n = numel(y);
plot(t,y)
yfft = fft(y);
fn = linspace(0,2,n);
figure
plot(fn,abs(yfft))
% criando um filtro fir
order = 200
win = hamming(order+1)
h =fir1(order,0.5,'high',win);
figure
plot(h)

yfiltered = conv(y,h,'Same')
% avaliando o filtro
close all
figure(10)
hfft = fft(h,n);
plot(fn,2*abs(yfft)./n,fn,abs(hfft))
% escale decibel
%plot(fn,10*log10(abs(yfft)./n),fn,10*log10(abs(hfft)))
xlim([0 1])
% resultado do filtro
% 
% subplot(2,1,1);plot(t,y)
% subplot(2,1,2);plot(t,yfiltered)
% 

%% soma de filtros 
order = 200
win = kaiser(order+1,11)
h1 =fir1(order,'high',[0.3],win);
h2 =fir1(order,'low',[0.5],win);

hh = h1 + h2;
yfilter = conv(y,hh,'Same')










