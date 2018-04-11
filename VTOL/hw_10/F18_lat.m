% Lateral Control Inner Loop
clear
Jc = .0042;
mr = 0.25;
d = 0.3;

Pi = tf(1/(Jc+2*mr*d^2),[1 0 0]);

figure(1),clf;
bode(Pi)
margin(Pi)

w_lead = 10; % rad/s
M = (1+sin(60.6*pi/180))/(1-sin(60.6*pi/180));
z = w_lead/sqrt(M);
p = w_lead*sqrt(M);

C = tf([1/z 1],[1/p 1]);
Ci = C;

% figure(2),clf;
% bode(Ci*Pi)
% margin(Ci*Pi)

K = 1/0.775;
Ci = K*Ci;

% figure(2),clf;
% bode(Ci*Pi)
% margin(Ci*Pi)

% Add low pass filter
p = 1000;
C = tf(p,[1 p]);
Ci = C*Ci;

figure(2),clf;
hold on
bode(Ci*Pi)
margin(Ci*Pi)

figure(1),clf;
step(feedback(Ci*Pi,1))

Ci
Cdi = c2d(Ci,0.01,'tustin')

%% Outer Loop

m = 1.5;
Fe = 9.81*m;
mu = 0.1;

Po = tf(-Fe,[m mu 0]);

figure(3),clf;
bode(-Po)
margin(-Po)
K=.7;

% Ki = .04;
Ki = .01;
C_int = -tf([1 Ki],[1 0]);
Co = K*C_int;

% figure(4),clf;
% hold on
% plot([100 100 100000],[1000000 10^-5 10^-5],'r')
% bode(Co*Po)
% margin(Co*Po)
% xlim([1e-2 1e3])
% hold off

w_lead = .975; % rad/s1.6
M = (1+sin(45*pi/180))/(1-sin(45*pi/180));
z = w_lead/sqrt(M);
p = w_lead*sqrt(M);

C_lead = tf([1/z 1],[1/p 1]);
Co = C_lead*C_lead*Co;

% figure(4),clf;
% hold on
% plot([100 100 100000],[1000000 10^-5 10^-5],'r')
% bode(Co*Po)
% margin(Co*Po)
% xlim([1e-2 1e3])
% hold off

K_lead = 1/35.0;
Co = K_lead*Co;

figure(4),clf;
hold on
plot([100 100 100000],[1000000 10^-5 10^-5],'r')
bode(Co*Po)
margin(Co*Po)
xlim([1e-2 1e3])
hold off

% Add low pass filter
p = 1.5;
C = tf(p,[1 p]);
Co = C*Co;

figure(4),clf;
hold on
plot([100 100 100000],[1000000 10^-5 10^-5],'r')
bode(Co*Po)
margin(Co*Po)
xlim([1e-2 1e3])
hold off

OsysCL = feedback(Co*Po,1);

figure(5),clf;
step(OsysCL)
Co
Cdo = c2d(Co,0.01,'tustin')