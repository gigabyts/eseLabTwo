%copied example removed comments and just renamed, changed or added
%variables as necessary
format long

AmpCosOne = 10;
AmpSinTwo = 3;
fCos = 10;
fSIn = 40;

deltaT = 0.01; 
TStop = 2;   
timeInterval = 0:deltaT:TStop-deltaT;     
fundFreq = 1/TStop;            

Stime = AmpCosOne*cos(2*pi*fCos*timeInterval) + AmpSinTwo*sin(2*pi*fSIn*timeInterval);

figure(1);
plot(timeInterval, Stime, 'Color', [.27 .89 .76]);
xlabel('time [sec]', 'Color', [1 .5 .314]);
title('Signal in time', 'Color', [1 .5 .314]);



%fourier 
nsize = length(Stime);
Sfreq = (1/nsize)*fft(Stime);  % this line does the fft; (1/nsize) is the scaling
deltaf = fundFreq;
FStop = nsize*deltaf;
freqIndex = 0:deltaf:FStop-deltaf;  


%real and im parts 
figure(2);
stem(freqIndex, real(Sfreq), 'Color', [.27 .89 .76], 'MarkerSize', 3);
xlabel('Frequency [Hz]','Color', [1 .5 .314]);
title('real part of S(f)','Color', [1 .5 .314]);

figure(3);
stem(freqIndex, imag(Sfreq), 'Color', [.27 .89 .76], 'MarkerSize', 3);
xlabel('Frequency [Hz]','Color', [1 .5 .314]);
title('imaginary part of S(f)','Color', [1 .5 .314]);


%filter high freq out
% idk how it works but refer to
%https://www.mathworks.com/help/signal/ug/practical-introduction-to-frequency-domain-analysis.html
%just consider the secondary signal and we do f_remove-f_1 and f_remove+f_1

Gfreq = Sfreq;               

fsamp = 1/deltaT; %should be 100          
Gfreq(freqIndex >= 20 & freqIndex <= 80) = 0;

figure(4);
stem(freqIndex, abs(Gfreq), 'Color', [.27 .89 .76], 'MarkerSize', 3);
xlabel('Frequency [Hz]','Color', [1 .5 .314]);
title('filtered func G(f)','Color', [1 .5 .314]);


%inverse transform
gtime = real(nsize*ifft(Gfreq));

figure(5);
plot(timeInterval, gtime, 'Color', [.27 .89 .76]);
xlabel('time [sec]', 'Color', [1 .5 .314]);
title('G(f) after inverse transform', 'Color', [1 .5 .314]);