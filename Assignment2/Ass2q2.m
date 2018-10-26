%Parker King-Fournier
%MUMT 307 Assignment 2 Question 2

%a. y[n] = 0.3x[n] + 1.5x[n-1] - 0.3x[n-2] - 2.3y[n-1] - 0.8y[n-2]
%b. y = {0.3, 0.81, -2.411, 4.8973, -13.19259}
%c. (below)
b = [0.3 1.5 -0.3];
a = [1 2.3 0.8];
x = [1  zeros(1,1999)];
y = filter(b,a,x);

%d. (below)
freqz(b,a,50);

%e. The filter is not stable because its impulse response does not decay
%   towards zero over time.