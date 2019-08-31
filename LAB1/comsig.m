% % LAB1 Ex.7
function comsig(a,b,n)
    s = exp((a+(i*b))*n);
    close all;
    figure;
    subplot(4,1,1);
    stem(n,abs(s));
    if b>0
        title({['\fontsize{16}e^{(',num2str(a),'+',num2str(b),'i)n}'];''});
    else
        title({['\fontsize{16}e^{(',num2str(a),num2str(b),'i)n}'];''});
    end
        
    xlabel('Magnitude');  % se z = x + iy, então |z| = sqrt(x^2 + y^2)
    subplot(4,1,2);
    stem(n,angle(s)); % arctan(y/x)
    xlabel('Fase');
    subplot(4,1,3);
    stem(n,real(s)); % real(exp(ix)) = (exp(ix)+(exp(-ix))/2
    xlabel('Parte Real');
    subplot(4,1,4);
    stem(n,imag(s)); % imag(exp(ix)) = (exp(ix)-(exp(-ix))/2i
    xlabel('Parte Imaginária');
end