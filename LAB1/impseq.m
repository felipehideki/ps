% % LAB1 Ex.1
function [x,n] = impseq(n0,n1,n2)
    if (n0<n1 | n2<n1 | n2<n0)
        error('impseq: valores de entrada inválidos.');    
    end
    k = 0.5; %passo: 0.5s
    n = [n1:k:n2];
    x = [(n-n0)==0];
end        

% % LAB1 Ex.6 a)
% [x1,n] = impseq(-2,-5,5);
% [x2,n] = impseq(4,-5,5);
% a = (2*x1)-x2;
% stem(n,a,'b^');