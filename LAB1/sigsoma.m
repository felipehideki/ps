% % LAB1 Ex.3
function [x,n] = sigsoma(x1,n1,x2,n2)
    if (n2<n1)
        error('sigsoma: intervalo de entrada n1:n2 inválido.');
    end
    k = 0.5; % passo: 0.5s
    n = [n1:k:n2];
    naux = [(((1/k)*n1)+1):((1/k)*n2)+1];
    if (length(x1)<(1/k)*n2)
        naux2 = [(((1/k)*n1)+1):length(x1)];
        aux1 = [x1(naux2) zeros(1,((1/k)*n2)-length(x1)+1)];
    else
        aux1 = x1(naux);
    end
    if (length(x2)<(1/k)*n2)
        naux3 = [(((1/k)*n1)+1):length(x2)];
        aux2 = [x2(naux3) zeros(1,((1/k)*n2)-length(x2)+1)];
    else
        aux2 = x2(naux);
    end
    x = [aux1 + aux2];
end