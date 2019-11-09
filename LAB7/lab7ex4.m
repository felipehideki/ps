% % LAB7 Ex.4
clear all
close all

load('som_baleia.mat');

ttotal = numel(w)/fs;
for j=1:2
    tz{j}=1/fs:1/fs:ttotal;
    sigz{j} = [w' zeros(1,numel(tz{j})*j)];
    sigf{j} = sigz{j}.*flattopwin(numel(sigz{j}))';
    sigfftz{j} = fftshift(fft(sigz{j}));
    sigfftf{j} = fftshift(fft(sigf{j}));
    nz(j) = numel(sigfftz{j});
    freqz{j} = linspace(-nz(j)/2,nz(j)/2,nz(j)).*fs/nz(j);
    if j==1
        figure;
    end
    subplot(2,1,j);
    plot(freqz{j},abs(sigfftz{j})/max(abs(sigfftz{j})),'LineWidth',1.5);
    xlim([0 fs/2]);
    str = sprintf('FFT som-baleia, zeros %dªordem', j);
    title(str);
    if j==2
        for k=1:2
            if k==1
                figure;
            end
            subplot(2,1,k);
            plot(freqz{k},abs(sigfftf{k})/max(abs(sigfftf{k})),'LineWidth',1.5);
            xlim([0 fs/2]);
            str2 = sprintf('FFT som-baleia, zeros %dªordem, janela Flat top', j);
            title(str2);
        end
    end
end  