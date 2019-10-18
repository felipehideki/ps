[y,f] = teltone_NA(12345);

fs = 5000;
ttotal = length(y)/fs;

t = 1/fs:1/fs:ttotal;

x = y ~= 0;
sw = 0;
cont = 1;

for i=1:length(y)-25
    if (x(i:i+25) == 0)
        if (sw == 1)
            termino(cont) = i;
            sinal{cont} = y(inicio(cont):termino(cont));
            sigfft{cont} = fft(sinal{cont});
            [pospeaks{cont},peaks{cont}] = findpeaks(abs(sigfft{cont}),'Minpeakheight', 620);
            sigfft{cont} = fftshift(sigfft{cont});
            n{cont} = numel(sigfft{cont});
            freq{cont} = linspace(-n{cont}/2,n{cont}/2,n{cont}).*fs/n{cont};
            sw = 0;
            cont = cont + 1;
        end
    else
        if (sw == 0)
            sw = 1;
            inicio(cont) = i;
        end
    end
end

% plot(freq{1},abs(sigfft{1}),'LineWidth',1.5);
% xlim([0 fs/2]);
