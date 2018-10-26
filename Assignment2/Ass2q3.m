%Parker King-Fournier
%MUMT 307 Assignment 2 Question 3

%a. (below)
b = [((1-(0.99)^2)/2) 0 -((1-(0.99)^2)/2)];
a = [1 -2*0.99*cos(2*pi*2000/44100) (0.99)^2 ];
x = [1 zeros(1,1999)];
y = filter(b,a,x);
freqz(b,a,100);

%b (below)
s = rand(1,10000).*2.-1;
t = filter(b,a,s);
figure();
spectrogram(t);