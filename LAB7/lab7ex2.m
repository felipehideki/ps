% LAB7 Ex.2
clear all
close all

fs = 250;
y = @(t) sin(2*pi*3.5*t)+sin(2*pi*3.75*t);
ttotal = [1 5 15];
janela = {'Triangular';'Hanning';'Hamming';'Flat top'};

for i=1:3
    for j=1:2
        tz{i}=1/fs:1/fs:ttotal(i);
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
        str = sprintf('FFT y[n], n = %ds, zeros %dªordem', i,j);
        title(str);
    end
end

for i=1:4
    for j=1:2
        tj{i,j}=1/fs:1/fs:ttotal(j);
        switch i 
            case 1
                sigj{i,j} = y(tj{i,j}).*triang(numel(tj{i,j}))';
            case 2
                sigj{i,j} = y(tj{i,j}).*hann(numel(tj{i,j}))';
            case 3
                sigj{i,j} = y(tj{i,j}).*hamming(numel(tj{i,j}))';
            case 4
                sigj{i,j} = y(tj{i,j}).*flattopwin(numel(tj{i,j}))';
        end
        sigfftj{i,j} = fftshift(fft(sigj{i,j}));
        nj(i,j) = numel(sigfftj{i,j});
        freqj{i,j} = linspace(-nj(i,j)/2,nj(i,j)/2,nj(i,j)).*fs/nj(i,j);
        if (j==1)
            figure;
        end
        subplot(2,1,j);
        plot(freqj{i,j},abs(sigfftj{i,j})/max(abs(sigfftj{i,j})),'LineWidth',1.5);
        xlim([0 fs/2]);
        str2{i} = sprintf('n = %ds, janela %s',ttotal(j),janela{i});
        title(str2{i});
    end
end