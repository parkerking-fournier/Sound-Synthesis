% Parker King-Fournier
% MUMT 307
% Assignment 1 Question 1 

% Read audio files
[y,~] = audioread('uncomp.wav');
[x,Fs] = audioread('comp.wav');

% Play uncompressed, then compressed file
sound(y,Fs);

disp('Hit any key to continue ...');
pause

sound(x,Fs);

disp('Hit any key to continue ...');
pause

% Calulcate Residue
r = y-x;

% Play Residue
sound(r,Fs);

% Plot Residue
WINDOW=1024;
NOVERLAP=512;
NFFT=1024;
spectrogram(r, WINDOW, NOVERLAP, NFFT, Fs);
title('Information Lost Due to Compression')