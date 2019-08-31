% % LAB1 Ex.2
function [x,n] = stepseq(n0,n1,n2)
    if (n0<n1 | n2<n1 | n2<n0)
        error('stepseq: valores de entrada inválidos.');
    end
    k = 0.5; %passo: 0.5s
    n = [n1:k:n2];
    x = [(n-n0)>=0];
end       

% % LAB1 Ex.6 b)
% [x1,n] = stepseq(0,0,20);
% [x2,n] = stepseq(10,0,20);
% [x3,n] = stepseq(20,0,20);
% b = (n.*(x1-x2))+((10*exp(-0.3*(n-10))).*(x2-x3));
% stem(n,b);

% % LAB1 Ex.6 c)
% n = [0:50];
% w = randn(1,50);
% c = cos(0.04*pi*n) + 0.2*w;
% stem(n,c);