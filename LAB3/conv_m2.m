% % LAB3 Ex.1 - Algoritmo sem necessidade dos vetores 'tamanho' nx e nh
function [y] = conv_m2(x,h)
    m = length(x);
    n = length(h);
    X = [x,zeros(1,n)]; % Adiciona zeros com o tamanho de h em x e vice-
    H = [h,zeros(1,m)]; % versa, portanto X e H possuem tamanhos iguais
    for i = 1:(n+m)-1
        y(i) = 0;
        for j = 1:m
            if (i-j+1 > 0)
                y(i) = y(i) + X(j) * H(i-j+1);
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
    stem(y,'-b^');
    title('Convolução y[n] = x[n]*h[n]');
    ylabel('y[n]'); 
    xlabel('n'); 
    grid on;
end

% % LAB3 Ex.2
% h = [2 3 0 -5 2 1];
% x = [3 11 7 4 0 -1 4 2];
% y = conv_m(x,h);