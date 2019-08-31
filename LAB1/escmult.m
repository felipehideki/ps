% % LAB1 Ex.5
function [x,n] = escmult(x1,n1,alpha)
    k = 0.5; % passo: 0.5s
    n = [0:k:n1];
    if (length(x1)<(1/k)*n1)
        aux = [x1 zeros(1,((1/k)*n1)-length(x1)+1)];
    else
        aux = x1;
    end
    x = alpha*aux;
end