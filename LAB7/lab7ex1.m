% LAB7 Ex.1

clear all
close all

fs = 100;
y = @(t) cos(2*pi*2.5*t);
janela = {'Triangular';'Hanning';'Hamming';'Flat top'};

for i=1:3
    t{i}=1/fs:1/fs:i;
    sig{i} = y(t{i});
    sigfft{i} = fftshift(fft(sig{i}));
    n(i) = numel(sigfft{i});
    freq{i} = linspace(-n(i)/2,n(i)/2,n(i)).*fs/n(i);
    if i==1
        figure;
    end
    subplot(3,1,i);
    plot(freq{i},abs(sigfft{i})/max(abs(sigfft{i})),'LineWidth',1.5);
    xlim([0 fs/2]);
    str = sprintf('FFT y[n] = cos[2*pi*2.5*n], n = %ds',i);
    title(str);
end

% O sinal possui frequ�ncia 2.5Hz. Isto significa que o sinal � peri�dico
% e se repete (de forma inteira) 5*N vezes somente quando 't' � um inteiro 
% par maior que zero, i.e., quando t = 2N, onde N = 1,2,3,...
% Para valores inteiros �mpares de 't', i.e., t = 2N-1, o sinal possuir� 
% (5*N)-3 repeti��es inteiras e mais metade (0.5) do sinal. Realizando FFT,
% essa metade n�o-inteira do sinal causa um ligeiro ru�do em todo o
% espectro de frequ�ncias, diminuindo a predomin�ncia da frequ�ncia 2.5Hz.

for i=1:3
    for j=1:2
        tz{i}=1/fs:1/fs:i;
        sigz{i,j} = [y(tz{i}) zeros(1,numel(tz{i})*j)];
        sigfftz{i,j} = fftshift(fft(sigz{i,j}));
        nz(i,j) = numel(sigfftz{i,j});
        freqz{i,j} = linspace(-nz(i,j)/2,nz(i,j)/2,nz(i,j)).*fs/nz(i,j);
        if (j==1)
            figure;
        end
        subplot(2,1,j);
        plot(freqz{i,j},abs(sigfftz{i,j})/max(abs(sigfftz{i,j})),'LineWidth',1.5);
        xlim([0 fs/2]);
        str = sprintf('FFT y[n], n = %ds, zeros %d�ordem', i,j);
        title(str);
    end
end

for i=1:4
    tj{i}=1/fs:1/fs:1;
    switch i 
        case 1
            sigj{i} = y(tj{i}).*triang(numel(tj{i}))';
        case 2
            sigj{i} = y(tj{i}).*hann(numel(tj{i}))';
        case 3
            sigj{i} = y(tj{i}).*hamming(numel(tj{i}))';
        case 4
            sigj{i} = y(tj{i}).*flattopwin(numel(tj{i}))';
    end
    sigfftj{i} = fftshift(fft(sigj{i}));
    nj(i) = numel(sigfftj{i});
    freqj{i} = linspace(-nj(i)/2,nj(i)/2,nj(i)).*fs/nj(i);
    if (i==1)
        figure;
    end
    subplot(4,1,i);
    plot(freqj{i},abs(sigfftj{i})/max(abs(sigfftj{i})),'LineWidth',1.5);
    xlim([0 fs/2]);
    str2{i} = sprintf('n = 1s, janela %s',janela{i});
    title(str2{i});  
end
