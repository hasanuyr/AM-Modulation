close all;
clear all;
%DSB-SC-AM
%%
%(i)Plotting Modulated Signal (y(t) and Y(F)) Spec.
%-----------------------------------------------------------------%
%Time specifications:
fs=10000; %sampling freq
time =(0:(1/fs):2-(1/fs));   % time  
%m(t) signal
messageSignal=(sin(2.*pi.*100.*time))+(5.*cos(2.*pi.*200.*time));
%y(t) signal 
modulatedSignal= 10.*messageSignal.*cos(2.*pi.*2000.*time);
%Y(f)
y_len=length(modulatedSignal);
freq=(-y_len/2:y_len/2-1)*(fs/y_len);
y_spectrum=abs(fftshift(fft(modulatedSignal))/y_len);

figure;
stem(freq,y_spectrum,'MarkerEdgeColor','white');
xlim([-4000 4000]);
title("|Y(f)|");
xlabel("frequency(Hz)");
ylabel("Amplitude");
legend('|Y(f)|');
grid on;

figure;
plot(time(1:200),10.*messageSignal(1:200),'b');
title("m(t)");
xlabel("time");
ylabel("Amplitude");
%legend('m(t)');
grid on;
grid minor;
hold on;
plot(time(1:200),-10.*messageSignal(1:200),'b');
title("m(t)");
xlabel("time");
ylabel("Amplitude");
%legend('m(t)');
grid on;
grid minor;
hold on;
plot(time(1:200),modulatedSignal(1:200),'r');
title("y(t)");
xlabel("time");
ylabel("Amplitude");
legend('+10m(t)','-10m(t)',' y(t)');
grid on;
hold off;


%%
%%(ii)Plotting LPF Input Signal (e(t) and E(f)) Spec.
%-----------------------------------------------------------------%
%e(t) signal 
lpfInputSignal= modulatedSignal.*cos(2.*pi.*2000.*time);
%E(f) 
e_len=length(lpfInputSignal);
freq=(-y_len/2:y_len/2-1)*(fs/e_len);
e_spectrum=abs(fftshift(fft(lpfInputSignal))/e_len);

figure;
plot(time(1:400),lpfInputSignal(1:400),'r');
title("LPF Input Signal");
xlabel("time(s)");
ylabel("Amplitude");
legend('e(t)');
grid on;
grid minor;

figure;
stem(freq,e_spectrum,'MarkerEdgeColor','white');
xlim([-6000 6000]);
title("|E(f)|");
xlabel("frequency(Hz)");
ylabel("Amplitude");
legend('E(f)');
grid on;
grid minor;

%%
%(iii)Plotting LPF Output Signal (z(t) and Z(f)) Spec.
%-----------------------------------------------------------------%
%Low Pass Filter 
LPF=[zeros(1,9600) ones(1,801) zeros(1,9599)]; 
%Z(f) 
z_spectrum=abs(LPF.*e_spectrum);
z_len=length(z_spectrum);
freq=(-z_len/2:z_len/2-1)*(fs/z_len);
%Z(f) find help with inverse fourier transform  
lpfOutputSignal=ifft(ifftshift(z_spectrum),z_len)*(z_len);

figure;
plot(time(1:400),lpfOutputSignal(1:400),'r');
title("LPF Output Signal");
xlabel("time(s)");
ylabel("Amplitude");
legend('z(t)');
grid on;
grid minor;

figure;
stem(freq,z_spectrum,'MarkerEdgeColor','white');
xlim([-900 900]);
title("|Z(f)|");
xlabel("frequency(Hz)");
ylabel("Amplitude");
legend('Z(f)');
grid on;
grid minor;

figure;
plot(freq,LPF);
xlim([-1000 1000]);
ylim([0 2]);
xlabel('frequency(Hz)');
ylabel('Amplitute');
title('LPF');
legend('H(f)');
grid on;
grid minor;






