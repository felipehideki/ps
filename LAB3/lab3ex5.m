% % LAB3 Ex.5 - DESAFIO
clear all;
close all;

load('ecos_ultrassom.mat');

% % a)
for i=1:size(ecos,1)
    [c{i},lag] = xcorr(pulse,ecos(i,:));
    peaks{i} = findpeaks(c{i},'Minpeakheight',200);
    numpeaks(i) = length(peaks{i});
end

% % b)
m = min(numpeaks); % Número mínimo de reflexões em cada eco, camadas

% % c)
auxr = numpeaks <= m; % Ecos com número de reflexões correspondentes à média
er = length(numpeaks(auxr)); % Número de ecos coletados corretamente
msgbox(sprintf('Foram coletados %g/100 ecos corretamente.', er));

% t = [1:length(pulse)]/fs;
% tlag = lag/fs;
% figure;
% plot(tlag, c{numero_do_eco});
% title('Eco nº',num2str(numero_do_eco));
% xlabel('time lag');
