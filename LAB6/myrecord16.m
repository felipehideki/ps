% % LAB6 Ex.1
function g16 = myrecord16(fs,tempo)
    recorder1 = audiorecorder(fs,16,1); % Objeto audiorecorder
    disp('------------------------GRAVANDO MICROFONE------------------------');
    record(recorder1);
    pause(tempo);
    stop(recorder1);
    disp('--------------------------FIM DA GRAVAÇÃO-------------------------');
    g16 = getaudiodata(recorder1); % Variável double
    figure;
    plot(g16);
    title('Gravação 16 bits');
    %     obj16 = audioplayer(recorder1); % 16 bits
    %     playblocking(obj16);
end

% % LAB6 Ex.2
% clear all
% close all
% 
% g1000 = myrecord16(1000,3);
% g1980 = myrecord16(1980,3);
% g5000 = myrecord16(5000,3);