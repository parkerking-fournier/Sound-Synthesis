% Parker King-Fournier
% MUMT 307
% Assignment 3 Question 2
b = [0.8];
a = [1 zeros(1,4998) 1];
x = [1  zeros(1,5000)];
y = filter(b,a,x);
freqz(y);

figure();

b = [0.81 -1.73 1];
a = [1 -1.73 0.81];
x = [1 zeros(1,99)];
y = filter(b,a,w);
freqz(y);