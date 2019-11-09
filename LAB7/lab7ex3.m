% % LAB7 Ex.3
clear all
close all

load('ex_03.mat');

sw = 0;
cont = 1;

for i=1:length(y)-250
    if (y(i:i+250) < 0.12)
        if (sw == 1)
            termino(cont) = i;
            sinal{cont} = y(inicio(cont):termino(cont));
%             sigfft{cont} = fft(sinal{cont});
%             [pospeaks{cont},peaks{cont}] = findpeaks(abs(sigfft{cont}),'Minpeakheight', 620);
%             sigfft{cont} = fftshift(sigfft{cont});
%             n{cont} = numel(sigfft{cont});
%             freq{cont} = linspace(-n{cont}/2,n{cont}/2,n{cont}).*fs/n{cont};
%             figure;
%             plot(freq{cont},abs(sigfft{cont})/max(abs(sigfft{cont})),'LineWidth',1.5);
%             xlim([0 fs/2]);
            ttotal(cont) = numel(sinal{cont})/fs;
            for j=1:2
                tz{cont}=1/fs:1/fs:ttotal(cont);
                sigz{cont,j} = [sinal{cont}' zeros(1,numel(tz{cont})*j)];
                sigfftz{cont,j} = fftshift(fft(sigz{cont,j}));
                nz(cont,j) = numel(sigfftz{cont,j});
                freqz{cont,j} = linspace(-nz(cont,j)/2,nz(cont,j)/2,nz(cont,j)).*fs/nz(cont,j);
                if j==1
                    figure;
                end
                subplot(2,1,j);
                plot(freqz{cont,j},abs(sigfftz{cont,j})/max(abs(sigfftz{cont,j})),'LineWidth',1.5);
                xlim([0 fs/2]);
                str = sprintf('FFT y%d[n], zeros %dªordem', cont,j);
                title(str);
            end        
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