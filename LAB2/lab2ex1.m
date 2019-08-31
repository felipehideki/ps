% % LAB2 Ex.1
clear all;
close all;

fs = 500;
n = [0:20]/fs;
x1 = 0.7*sin(2*pi*50*n);
x2 = sin(2*pi*120*n);

figure;
subplot(2,1,1);
stem(n,x1);
title('x1 = 0.7*sin(2*pi*50*n)');
subplot(2,1,2);
stem(n,x2);
title('x2 = sin(2*pi*120*n)');