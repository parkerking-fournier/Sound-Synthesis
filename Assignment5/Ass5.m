% Parker King-Fournier 
% MUMT 307
% Assignment 5

%Read in the audio file
[y,Fs] = audioread('piano.wav');

%These Variables will be used later a lot. The segLength is the number of
%samples per segment. The original file was 24931, so i decided to split it
%up into 9 sections of size 2493 and one of size 2494
N = length(y);
segLength = 2493;
T = N ./ Fs ;

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
%plot(f,Y1);
%figure;
%Y2 = fft(segment2,segLength);
%Y2 = abs( Y2(1:segLength) ) ./ (segLength);
%plot(f,Y2);
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


%Envelope for frequency 1
%Notice how 'y' starts with two 1.0000's. This is because from time 0 to
%time 113.07, the amplitude of the first frequency was the highest of all
%the amplitudes throughout the sample. I normalized everything else to
%this. 
Q = 1/Fs;
x = [0 113.07 226.14 339.21 452.28 565.35 678.42 791.49 904.56 1017.63 1130.7];
y = [1.0000 1.0000 0.8681 0.2664 0.3730 0.1455 0.1220 0.1619 0.3197 0.1322 0.1509];
n = 0:Fs*T;
env1 = interp1(x, y, 1000*n*Q);

%Envelope for frequency 2
y = [0.0335 0.0335 0.0332 0.0268 0.0227 0.0176 0.0154 0.0155 0.0142 0.0072 0.0189];
env2 = interp1(x, y, 1000*n*Q);

%Envelope for frequency 3
y = [0.0117 0.0117 0.0092 0.0086 0.0052 0.0035 0.0028 0.0030 0.0028 0.0015 0.0041];
env3 = interp1(x, y, 1000*n*Q);

%Envelope for frequency 3
y = [0.0068 0.0068 0.0042 0.0042 0.0040 0.0012 0.0012 0.0015 0.0008 0.0011 0.0013];
env4 = interp1(x, y, 1000*n*Q);


%Frequencies were found using 'analyze.m', a free software made by:
%Mark R. Petersen, U. of Colorado Boulder Applied Math Dept, Feb 2004
%it showed a graph of the power of different frequencies with corresponding
%hZ. 
f1 = 866.7;
f2 = 1741;
f3 = 2622;
f4 = 3521;

%resulting sine wave with each frequency that is scaled by its respective
%envelope.
t = 0:(1/Fs):T;
curve = sin(2*pi*f1*t).*env1 + sin(2*pi*f2*t).*env2 + sin(2*pi*f3*t).*env3 + sin(2*pi*f4*t).*env4;

%make some white noise cuz thats whats in the recording
y = wgn(1,24932,-6).*0.0065;

%sound the sounds!
sound(curve, Fs);
sound(y, Fs);
