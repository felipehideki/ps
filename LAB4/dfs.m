% % LAB4 Ex.1

function xk = dfs2(xn,n,k)
    len = length(xn);
    Xn(1:len) = 1:len;
    xk = Xn*exp(-j*pi/k(end)).^n'*k;
end
