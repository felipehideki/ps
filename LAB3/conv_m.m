% % LAB3 Ex.1
function [Y,ny] = conv_m(x,nx,h,nh)
    nya = nx(1) + nh(1);
    nyb = nx(end) + nh(end);
    ny = [nya:nyb];
    X = [x,zeros(1,length(nh))]; % Adiciona zeros com o tamanho de h em x e vice-
    H = [h,zeros(1,length(nx))]; % versa, portanto X e H possuem tamanhos iguais
    for i = 1:(length(x)+length(h))-1
        Y(i) = 0; % Inicializando vetor Y
        for j = 1:length(x)
            if (i-j+1 > 0)
                Y(i) = Y(i) + X(j) * H(i-j+1);
            else
            end
        end
    end
    figure;
    subplot(3,1,1); 
    stem(x,'-ro'); 
    xlabel('n');
    ylabel('x[n]'); 
    grid on;
    subplot(3,1,2); 
    stem(h,'-ms');
    xlabel('n'); 
    ylabel('h[n]'); 
    grid on;
    subplot(3,1,3); 
    stem(Y,'-b^');
    title('Convolução y[n] = x(n)*h(n)');
    ylabel('y[n]'); 
    xlabel('n'); 
    grid on;
end

% % LAB3 Ex.2
% h = [2 3 0 -5 2 1];
% nh = -1:4;
% x = [3 11 7 4 0 -1 4 2];
% nx = -3:3;
% [y,ny] = conv_m(x,nx,h,nh);
