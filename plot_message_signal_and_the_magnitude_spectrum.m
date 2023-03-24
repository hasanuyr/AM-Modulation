close all;
clear all;
clc;
%Time specifications:
fs=10000; %sampling freq
time =(0:(1/fs):2-(1/fs));   % time  

% m(t) signal
messageSignal = (sin(2.*pi.*100.*time))+(5.*cos(2.*pi.*200.*time));
%  FT of m(t)
magMessagefunc = fft(messageSignal);   
%Frequency specifications
m_len=length(messageSignal);
freq=(-m_len/2:m_len/2-1)*(fs/m_len);
% M(f) Specifications   
m_spectrum=abs(fftshift(magMessagefunc)/m_len);
%Plotting
figure;
plot(time(1:100),messageSignal(1:100),'r');
title("Message Signal");
xlabel("time(s)");
ylabel("m(t)");
legend('m(t)');
grid on;
grid minor;

figure;
stem(freq,m_spectrum,'MarkerEdgeColor','white');
xlim([-400 400]);
title("|M(f)|");
xlabel("frequency(Hz)");
ylabel("Amplitude");
legend('M(f)');
grid on;
grid minor;