fs=10000; %sampling freq
time=0:(1/fs):1;
freq=-fs/2:fs/2;
mu=0.6
%m(t)
messageSignal=(sin(2*pi*100*time))+(5*cos(2*pi*200*time));
Ac= 10;
%c(t)
carrierSignal=cos(2*pi*2000*time);
%y(t)
modulatedSignal=Ac.*(1+(0.6.*messageSignal/5)).*carrierSignal;
%Y(f)
y_spectrum=abs(fftshift(fft(modulatedSignal))/fs);

figure;
plot(time(1:300),modulatedSignal(1:300));
title("Modulated Signal (DSB-LC AM )");
xlabel("time");
ylabel("Amplitude");
legend('y(t)');
grid on;


figure;
stem(freq,y_spectrum,'MarkerEdgeColor','white');
xlim([-4000 4000]);
title("Y(f)");
xlabel("frequency");
ylabel("Amplitude");
legend('Y(f)');
grid on;

%%
%(ii) Demodulating the AM signal
%-----------------------------------------------------------------%
freq=-fs/2:fs/2;
envelopeSignal= modulatedSignal.*carrierSignal;
e_spectrum=abs(fftshift(fft(envelopeSignal))/fs);
%Low Pass Filter 
LPF=[zeros(1,4800) ones(1,200) zeros(1,1) ones(1,200) zeros(1,4800)]; 
%Subtacting the DC component with zeros(1,1)
%Applied LPF to e_spectrum
z_spectrum=abs(LPF.*e_spectrum);
%Demodulated signal find help with inverse fourier transform  
demodulatedSignal=ifft(ifftshift(z_spectrum),fs)*(fs);
figure;
plot(time(1:400),demodulatedSignal(1:400),'r');
title("z(t)");
xlabel("time(s)");
ylabel("Amplitude");
legend('z(t)');
grid on;
grid minor;
figure
stem(freq,z_spectrum,'MarkerEdgeColor','white');
xlim([-900 900]);
title("Z(f)");
xlabel("frequency(Hz)");
ylabel("Amplitude");
legend('Z(f)');
grid on;
grid minor;

