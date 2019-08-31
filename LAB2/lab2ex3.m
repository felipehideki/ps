% % LAB2 Ex.3 a)
clear all;
close all;

som = load('som_baleia.mat');
fs = som.fs;
n = [1:length(som.w)]/fs; % length() == numel() para 1xN arrays
figure(1);
subplot(3,2,[1 2]);
stem(n,som.w);
title('Original');

% % LAB2 Ex.3 b)
n1 = n>1.4 & n<3.4;
n2 = n>6 & n<8;
n3 = n>11.4 & n<13.4;
n4 = n>16.4 & n<18.4;

subplot(3,2,3);
stem(n(n1),som.w(n1));
title('S1');
subplot(3,2,4);
stem(n(n2),som.w(n2));
title('S2');
subplot(3,2,5);
stem(n(n3),som.w(n3));
title('S3');
subplot(3,2,6);
stem(n(n4),som.w(n4));
title('S4');