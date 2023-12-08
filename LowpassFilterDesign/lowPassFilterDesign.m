%%filter with 0.01 sample time in simulink

clc; close all; clear;


load("theta0_01.mat")
load("theteDotUF_0_01.mat")

t = theta.Time;
thetaData = theta.Data;
thetaDotData = theteDotUF.Data;


fs=100 %sample Freuency 
fn=fs/2; % Nyquist Frequency 
%fc=0.1; % Desired Cutoff frequency (example)
fc=1
[b,a]=butter(1,fc/fn);
% [h,w] = freqz(b,a,100);
% figure(1)
% subplot(2,1,1)
% plot(abs(h))
% subplot(2,1,2)
% plot(w)
%[b,a] = butter(6,20/(fs/2));
thetaFiltered = filter(b,a,thetaData);
thetaDotFiltered = filter(b,a,thetaDotData);

figure% TEST BODE OF FILTER
s = tf('s')
Gfilt = (b(1)*s +b(2))/(a(1)*s+a(2)) %This filter should be tried in simulink
bode(Gfilt)



figure %THETA
plot(t(:,1),thetaData(:))
hold on
plot(t,thetaFiltered(:))
legend('Theta UF','Theta F')

figure %THETADOT
plot(t(:,1),thetaDotData(:))
hold on
plot(t,thetaDotFiltered(:))
legend('ThetaDot UF','ThetaDot F')
xlim([102.65 105])
