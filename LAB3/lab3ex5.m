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
m = median(numpeaks); % N�mero m�dio de reflex�es em cada eco, camadas

% % c)
auxr = numpeaks <= m; % Ecos com n�mero de reflex�es correspondentes � m�dia
er = length(numpeaks(auxr)); % N�mero de ecos coletados corretamente
msgbox(sprintf('Foram coletados %g/100 ecos corretamente.', er));

% t = [1:length(pulse)]/fs;
% tlag = lag/fs;
% figure;
% plot(tlag, c{numero_do_eco});
% title('Eco n�',num2str(numero_do_eco));
% xlabel('time lag');
