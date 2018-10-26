% Parker King-Fournier
% MUMT 307
% Assignment 1 Question 3

%set the length of sections, 
%read audiofile
%calculate the number of sections
M = 4275;
[y,Fs] = audioread('uncomp.wav');
subsets = length(y) / M;

%variables
k = size(y);
z = length(y);

%plot signal
%make graph pretty, etc.
plot(y,'k');
xlabel('Time (seconds)');
ylabel('Signal Amplitude');
ax.XTickLabel = {'0','0.2','0.4','0.6','0.8','1','1.2','1.4','1.6','1.8','2'};
grid on;
hold on;

% legend('signal','mean','power','rms power','variance');
x = reshape(y,M,subsets);

%calculate the power
powwer = sum(x.^2)./M;
powwer1 = ones(1,M).*powwer(1);
powwer2 = ones(1,M).*powwer(2);
powwer3 = ones(1,M).*powwer(3);
powwer4 = ones(1,M).*powwer(4);
powwer5 = ones(1,M).*powwer(5);
powwer6 = ones(1,M).*powwer(6);
powwer7 = ones(1,M).*powwer(7);
powwer8 = ones(1,M).*powwer(8);
powwer9 = ones(1,M).*powwer(9);
powwer10 = ones(1,M).*powwer(10);
powwer11 = ones(1,M).*powwer(11);
powwer12 = ones(1,M).*powwer(12);
powwer13 = ones(1,M).*powwer(13);
powwer14 = ones(1,M).*powwer(14);
powwer15 = ones(1,M).*powwer(15);
powwer16 = ones(1,M).*powwer(16);
powwer17 = ones(1,M).*powwer(17);
powwer18 = ones(1,M).*powwer(18);
powwer19 = ones(1,M).*powwer(19);
powwer20 = ones(1,M).*powwer(20);
%combine all of the powers into one long row vector
powwers = [powwer1 powwer2 powwer3 powwer4 powwer5 powwer6 powwer7 powwer8 powwer9 powwer10 powwer11 powwer12 powwer13 powwer14 powwer15 powwer16 powwer17 powwer18 powwer19 powwer20];
plot(powwers,'g');

%calculate rms
rms = sqrt(powwer);
rms1 = ones(1,M).*rms(1);
rms2 = ones(1,M).*rms(2);
rms3 = ones(1,M).*rms(3);
rms4 = ones(1,M).*rms(4);
rms5 = ones(1,M).*rms(5);
rms6 = ones(1,M).*rms(6);
rms7 = ones(1,M).*rms(7);
rms8 = ones(1,M).*rms(8);
rms9 = ones(1,M).*rms(9);
rms10 = ones(1,M).*rms(10);
rms11 = ones(1,M).*rms(11);
rms12 = ones(1,M).*rms(12);
rms13 = ones(1,M).*rms(13);
rms14 = ones(1,M).*rms(14);
rms15 = ones(1,M).*rms(15);
rms16 = ones(1,M).*rms(16);
rms17 = ones(1,M).*rms(17);
rms18 = ones(1,M).*rms(18);
rms19 = ones(1,M).*rms(19);
rms20 = ones(1,M).*rms(20);
%combine all rms's into one long row vector
rmss = [rms1 rms2 rms3 rms4 rms5 rms6 rms7 rms8 rms9 rms10 rms11 rms12 rms13 rms14 rms15 rms16 rms17 rms18 rms19 rms20];
plot(rmss,'b');

%calculate mean
meen = sum(x)./M;
meen1 = ones(1,M).*meen(1);
meen2 = ones(1,M).*meen(2);
meen3 = ones(1,M).*meen(3);
meen4 = ones(1,M).*meen(4);
meen5 = ones(1,M).*meen(5);
meen6 = ones(1,M).*meen(6);
meen7 = ones(1,M).*meen(7);
meen8 = ones(1,M).*meen(8);
meen9 = ones(1,M).*meen(9);
meen10 = ones(1,M).*meen(10);
meen11 = ones(1,M).*meen(11);
meen12 = ones(1,M).*meen(12);
meen13 = ones(1,M).*meen(13);
meen14 = ones(1,M).*meen(14);
meen15 = ones(1,M).*meen(15);
meen16 = ones(1,M).*meen(16);
meen17 = ones(1,M).*meen(17);
meen18 = ones(1,M).*meen(18);
meen19 = ones(1,M).*meen(19);
meen20 = ones(1,M).*meen(20);
%combine all means into one long row vector
meens = [meen1 meen2 meen3 meen4 meen5 meen6 meen7 meen8 meen9 meen10 meen11 meen12 meen13 meen14 meen15 meen16 meen17 meen18 meen19 meen20];
plot(meens,'r');

%calculate variance
var = (y' - meens).^2;
var = reshape(var,M,subsets);
var = sum(var)./M;
var1 = ones(1,M).*var(1);
var2 = ones(1,M).*var(2);
var3 = ones(1,M).*var(3);
var4 = ones(1,M).*var(4);
var5 = ones(1,M).*var(5);
var6 = ones(1,M).*var(6);
var7 = ones(1,M).*var(7);
var8 = ones(1,M).*var(8);
var9 = ones(1,M).*var(9);
var10 = ones(1,M).*var(10);
var11 = ones(1,M).*var(11);
var12 = ones(1,M).*var(12);
var13 = ones(1,M).*var(13);
var14 = ones(1,M).*var(14);
var15 = ones(1,M).*var(15);
var16 = ones(1,M).*var(16);
var17 = ones(1,M).*var(17);
var18 = ones(1,M).*var(18);
var19 = ones(1,M).*var(19);
var20 = ones(1,M).*var(20);
%combine all variances into one long row vector
vars = [var1 var2 var3 var4 var5 var6 var7 var8 var9 var10 var11 var12 var13 var14 var15 var16 var17 var18 var19 var20];
plot(vars,'m');

%make the legend
legend( 'signal', 'power', 'rms power', 'mean', 'variance' );

hold off;