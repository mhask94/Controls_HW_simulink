%% Longitudinal Controller
m = 1.5;
P_lon = tf(1/m,[1 0 0]);

figure(1),clf;
bode(P_lon)

Ki = .1;
C_lon = tf([1 Ki],[1 0]);

figure(2),clf;
hold on
plot([10^-6 .1 .1],[99 99 10^-6],'k')
plot([200 200 100000],[100000 10^-4 10^-4],'r')
bode(C_lon*P_lon)
margin(C_lon*P_lon)
xlim([1e-2 1e3])
hold off

% Add lead

w_lead = 2.75; % rad/s
M = (1+sin(69.6*pi/180))/(1-sin(69.6*pi/180));
z = w_lead/sqrt(M);
p = w_lead*sqrt(M);

C = tf([1/z 1],[1/p 1]);
C_lon = C*C_lon;

% figure(2),clf;
% hold on
% plot([10^-6 .1 .1],[99 99 10^-6],'k')
% plot([200 200 100000],[100000 10^-4 10^-4],'r')
% bode(C_lon*P_lon)
% margin(C_lon*P_lon)
% xlim([1e-2 1e3])
% hold off

K = 1/0.7;
C_lon = K*C_lon;

figure(2),clf;
hold on
plot([10^-6 .1 .1],[99 99 10^-6],'k')
plot([200 200 100000],[100000 10^-4 10^-4],'r')
bode(C_lon*P_lon)
margin(C_lon*P_lon)
xlim([1e-2 1e3])
hold off

% Add low pass filter
p = 20;
C = tf(p,[1 p]);

C_lon = C*C_lon;

figure(2),clf;
hold on
plot([10^-6 .1 .1],[99 99 10^-6],'k')
plot([200 200 100000],[100000 10^-4 10^-4],'r')
bode(C_lon*P_lon)
margin(C_lon*P_lon)
xlim([1e-2 1e3])
hold off

sysCL = feedback(C_lon*P_lon,1);

figure(3),clf;
step(sysCL)
% PreFilter

a = 1.5;
% a = 55;
F = tf(a,[1 a]);

% Plot CL FR with prefilter applied
figure(4); clf;
% bode(F*sysCL,sysCL,F)
bode(F*C_lon*P_lon,C_lon*P_lon)
legend('FCP','CP')
% step(F)

figure(5); clf;
step(F*sysCL,sysCL)
legend('Filter','No-Filter')

C_lon
Cd_lon = c2d(C_lon,0.025,'tustin')

F
Fd = c2d(F,.025,'tustin')