% Parker King-Fournier 
% MUMT 307
% Assignment 7

%Read in the audio file for the piano that I am synthesizing
%[y,Fs] = audioread('piano.wav');

%These Variables will be used later a lot. The segLength is the number of
%samples per segment. The original file was 24931, so i decided to split it
%up into 9 sections of size 2493 and one of size 2494
%N = length(y);
%segLength = 2493;
%T = N ./ Fs ;

%It would have been ideal to use a for-loop here to do this, however
%everytime I use a for-loop on matlab on my machine it goes crazy and heats
%up and scares me, so I had to do it the old fashioned way.
%segment1 = y(1:2493);
%segment2 = y(2949:4968);
%segment3 = y(4969:7479);
%segment4 = y(7480:9972);
%segment5 = y(9973:12465);
%segment6 = y(12466:14598);
%segment7 = y(14959:17451);
%segment8 = y(17452:19944);
%segment9 = y(19945:22437);
%segment10 = y(22438:24931);

%This whole mess coulda been avoided with a simple for-loop!
%This does the fft at each interval, then plotted each of them and used the
%plots to get relative amplitudes to each other and normalized them to the
%highest amplitude of them all. 
%f = Fs/N .* (0:segLength-1); 
%Y1 = fft(segment1,segLength);
%Y1 = abs( Y1(1:segLength) ) ./ (segLength);
%%%y1db = mag2db(Y1);
%plot(f,y1db);
%figure;
%Y2 = fft(segment2,segLength);
%Y2 = abs( Y2(1:segLength) ) ./ (segLength);
%%%y2db = mag2db(Y2);
%plot(f,y2db);
%figure;
%Y3 = fft(segment3,segLength);
%Y3 = abs( Y3(1:segLength) ) ./ (segLength);
%plot(f,Y3);
%figure;
%Y4 = fft(segment4,segLength);
%Y4 = abs( Y4(1:segLength) ) ./ (segLength);
%plot(f,Y4);
%figure;
%Y5 = fft(segment5,segLength);
%Y5 = abs( Y5(1:segLength) ) ./ (segLength);
%plot(f,Y5);
%figure;
%Y6 = fft(segment6,segLength);
%Y6 = abs( Y6(1:segLength) ) ./ (segLength);
%plot(f,Y6);
%figure;
%Y7 = fft(segment7,segLength);
%Y7 = abs( Y7(1:segLength) ) ./ (segLength);
%plot(f,Y7);
%figure;
%Y8 = fft(segment8,segLength);
%Y8 = abs( Y8(1:segLength) ) ./ (segLength);
%plot(f,Y8);
%figure;
%Y9 = fft(segment9,segLength);
%Y9 = abs( Y9(1:segLength) ) ./ (segLength);
%plot(f,Y9);
%figure;
%f = Fs/N .* (0:segLength); 
%Y10 = fft(segment5,segLength+1);
%Y10 = abs( Y10(1:segLength+1) ) ./ (segLength + 1);
%plot(f,Y10);
%figure;

%Read in the hit that I made
[x,Fs] = audioread('hit.wav');
x = (x(:,2) + x(:,1))./2;

%Frequencies were found using 'analyze.m', a free software made by:
%Mark R. Petersen, U. of Colorado Boulder Applied Math Dept, Feb 2004
%it showed a graph of the power of different frequencies with corresponding
%hZ. 
f1 = 866.7;
f2 = 1741;
f3 = 2622;
f4 = 3521;

% Filters for the frequencies
% Each filter has its own r value that I found by looking 
% at the bandwidths of the respective frequencies
r1 = exp(-pi*0.6/Fs);
a = [1 -2*r1*cos(2*pi*f1/Fs) (r1)^2 ];
b = [((1-(r1^2))/2) 0 -((1-(r1^2))/2)];
y = filter(b,a,x);

r2 = exp(-pi*1.1/Fs);
a = [1 -2*r2*cos(2*pi*f2/Fs) (r2)^2 ];
b = [((1-(r2^2))/2) 0 -((1-(r2^2))/2)];
z = filter(b,a,x);
z = z.*0.0335;

r3 = exp(-pi*1.1/Fs);
a = [1 -2*r3*cos(2*pi*f3/Fs) (r3)^2 ];
b = [((1-(r3^2))/2) 0 -((1-(r3^2))/2)];
t = filter(b,a,x);
t = t.*0.0117;

r4 = exp(-pi*0.7/Fs);
a = [1 -2*r4*cos(2*pi*f4/Fs) (r4)^2 ];
b = [((1-(r4^2))/2) 0 -((1-(r4^2))/2)];
v = filter(b,a,x);
v = v.*0.0068;

% Sound all of the filters added together. I multiplied it by an arbitrary 
% value of 40 because without it the sound was super quiet
sound(40*(y+z+t+v), Fs);