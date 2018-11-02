% Inner Loop
l = 0.5;
c1 = 5.303867403314917;

Pi = tf(c1*l,[1 0 0]);

figure(1),clf;
bode(Pi)

% add lead

w_lead = 25; % rad/s
M = (1+sin(63.4*pi/180))/(1-sin(63.4*pi/180));
z = w_lead/sqrt(M);
p = w_lead*sqrt(M);

C = tf([1/z 1],[1/p 1]);

% figure(2); clf;
% bode(C*Pi)
% margin(C*Pi)
% 
% figure(3),clf;
% hold on
% bodemag(C*Pi)
% plot([10^-6 1 1],[311.5 311.5 10^-6],'k')
% plot([1000 1000 100000],[100000 .0032 .0032],'r')
% hold off
% xlim([10^-3 10^4])

K = 1 /.0169;
C = K*C;

% figure(2); clf;
% bode(C*Pi)
% margin(C*Pi)
% 
% figure(3),clf;
% hold on
% bodemag(C*Pi)
% plot([10^-6 1 1],[311.5 311.5 10^-6],'k')
% plot([1000 1000 100000],[100000 .0032 .0032],'r')
% hold off
% xlim([10^-3 10^4])

% add lag
M_lag = 9;
z_lag = 1.75;
p_lag = z_lag/M_lag;

C_lag = tf(M_lag*[1/z_lag 1],[1/p_lag 1]);

C = C_lag*C;

figure(2); clf;
hold on
plot([10^-6 1 1],[311.5 311.5 10^-6],'k')
plot([1000 1000 100000],[100000 .0032 .0032],'r')
bode(C*Pi)
margin(C*Pi)
hold off

% figure(3),clf;
% hold on
% bodemag(C*Pi)
% plot([10^-6 1 1],[311.5 311.5 10^-6],'k')
% plot([1000 1000 100000],[100000 .0032 .0032],'r')
% hold off
% xlim([10^-3 10^4])

[m,p] = bode(C*Pi,1000);

sysOL = C*Pi;
sysCL = feedback(C*Pi,1);

figure(4),clf;
step(sysCL)

C
Ci_d = c2d(C,.01,'tustin')

% Outer Loop

Po = tf(-9.81,[1 0 0])*sysCL;

% figure(5),clf;
% hold on
% plot([10^-6 .1 .1],[100 100 10^-6],'k')
% plot([100 100 100000],[100000 .001 .001],'r')
% bode(Co*Po)
% margin(Co*Po)
% hold off

% figure(6),clf;
% hold on
% bodemag(-Po)
% plot([10^-6 .1 .1],[100 100 10^-6],'k')
% plot([100 100 100000],[100000 .001 .001],'r')
% hold off
% xlim([10^-2 10^4])


% add lead control
w_lead = 3.14; % rad/s
M = (1+sin(60*pi/180))/(1-sin(60*pi/180));
z = w_lead/sqrt(M);
p = w_lead*sqrt(M);

Co = -tf([1/z 1],[1/p 1]);

% figure(5),clf;
% bode(Co*Po)
% margin(Co*Po)
% 
% figure(6),clf;
% hold on
% bodemag(Co*Po)
% plot([10^-6 .1 .1],[100 100 10^-6],'k')
% plot([100 100 100000],[100000 .001 .001],'r')
% hold off
% xlim([10^-2 10^4])

Ko = 1 / 3.9;
Co = Ko*Co;

figure(5),clf;
hold on
plot([10^-6 .1 .1],[100 100 10^-6],'k')
plot([100 100 100000],[100000 .001 .001],'r')
bode(Co*Po)
margin(Co*Po)
hold off

% figure(6),clf;
% hold on
% bodemag(Co*Po)
% plot([10^-6 .1 .1],[100 100 10^-6],'k')
% plot([100 100 100000],[100000 .001 .001],'r')
% hold off
% xlim([10^-2 10^4])

OutSysOL = Co*Po;
OutSysCL = feedback(Co*Po,1);

figure(7),clf;
step(OutSysCL)

Co
Co_d = c2d(Co,.01,'tustin')