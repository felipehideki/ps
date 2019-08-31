% % LAB2 Ex.4
function [recorder1, recorder2] = myrecord(tempo,fs,nbits1,nbits2)
    recorder1 = audiorecorder(fs,nbits1,1); % Objeto audiorecorder
    recorder2 = audiorecorder(fs,nbits2,1);
    disp('------------------------GRAVANDO MICROFONE------------------------');
    record(recorder1);
    record(recorder2);
    pause(tempo);
    stop(recorder1);
    stop(recorder2);
    disp('--------------------------FIM DA GRAVA��O-------------------------');
    g8 = getaudiodata(recorder1); % Vari�vel double
    g16 = getaudiodata(recorder2);
    figure;
    subplot(2,1,1);
    plot(g8);
    title('Grava��o 8 bits');
    subplot(2,1,2);
    plot(g16);
    title('Grava��o 16 bits');
    %     obj8 = audioplayer(recorder2); % 8 bits
    %     playblocking(obj8);
    %     obj16 = audioplayer(recorder2); % 16 bits
    %     playblocking(obj16);
end