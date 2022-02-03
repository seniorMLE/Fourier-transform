clear;
clc;


[y,Fs] = audioread('Sample_Audio.wav'); %read audio sample file from computer



fig = figure('Position', [100 170 1600 800]);


subplot(5, 2, 1);

y_fft = fft(y);
plot(mag2db(abs(y_fft(:,1))))  %plot the Fourrier representation of the signal 
title('Fourier representation');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
sound(y,Fs);


Fs = 44100;
Fc = 2400;
Wn = (Fc/(Fs/2));

%butterworth filters
subplot(5,2,3);
[b,a] = butter(4,Wn);
butter4 = filter(b,a,y_fft);
sound(y,Fs);

plot(mag2db(abs(butter4(:,1))));
title('Butterworth filter order=4');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');

subplot(5,2,4);
[c,d] = butter(8,Wn);
butter8 = filter(c,d,y_fft);
plot(mag2db(abs(butter8(:,1))));
title('Butterworth IIR filter order=8');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');



%hamming windows
x8 = (-8/2):1:(8/2); 
x32 = (-32/2):1:(32/2); 
x128 = (-128/2):1:(128/2); 

A = 1; 
N = 512;  
cut = 0.1*pi; 
rham8 = hamming(9);  
rham128 = hamming(129);  
ham8 = (sinc(cut*x8).*rham8')./10; 
ham128 = (sinc(cut*x128).*rham128')./10; 

subplot(5,2,5);
hamming8 = filter(ham8,A,y_fft);
plot(mag2db(abs(hamming8(:,1))));
title('Hamming FIR M=8');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');

subplot(5,2,6);
hamming128 = filter(ham128,A,y_fft);
plot(mag2db(abs(hamming128(:,1))));
title('Hamming FIR M=128');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');


%rectangular windows
x8 = (-8/2):1:(8/2); 
x32 = (-32/2):1:(32/2); 
x128 = (-128/2):1:(128/2); 

A = 1; 
N = 512;  
cut = 0.1*pi; 
rwin8 = rectwin(9);
rwin128 = rectwin(129);
rect8 = (sinc(cut*x8).*rwin8')./10; 
rect128 = (sinc(cut*x128).*rwin128')./10; 

rectwin8 = filter(rect8,A,y_fft);
subplot(5,2,7);
plot(mag2db(abs(rectwin8(:,1))));
title('rectangular window FIR M=8');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');

subplot(5,2,8);
rectwin128 = filter(rect128,A,y_fft);
plot(mag2db(abs(rectwin128(:,1))));
title('rectangular window FIR M=128');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
%bessel filter
[e,f] = besself(8,Fc*(2*pi));
[num,den] = bilinear(e,f,Fs);
bessel8 = filter(num,den,y_fft);
subplot(5,2,9);
plot(mag2db(abs(bessel8(:,1))));
title('Bessel IIR filter M=8');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');





