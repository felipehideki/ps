%% filtro de passa baixa e janela kaiser
order = 100;
win = kaiser(order+1,5);
h = fir1(order,0.4,'high',win)
fvtool(h)
%% filtro de passa banda e janela hamming
order = 80;
win = hamming(order+1);
h = fir1(order,[0.4 0.6],'bandpass',win)
figure
fvtool(h)

%% filtro de passa banda e janela hamming
order = 80;
win = hamming(order+1);
h = fir1(order,[0.4],'high',win)
figure
fvtool(h)

%% filtro de passa banda e janela ham
order = 80;
win = hann(order+1);
h = fir1(order,[0.4],'high',win)
figure
fvtool(h)
%% soma de filtros
order = 160;
win = hamming(order+1);
h = fir1(order,[0.4],'high',win)
fvtool(h)
hh = fir1(order,[0.5],'low',win)
fvtool(hh)
hhh = fir1(order,[0.6],'high',win)
fvtool(hhh)
hhhh = fir1(order,[0.7],'low',win)
fvtool(hhhh)
fvtool(h+hh+hhh+hhhh)
