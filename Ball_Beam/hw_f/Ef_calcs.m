m1 = .35;
m2 = 2;
l = .5;
g = 9.8;
ze = l/2;

C1 = 3/(m2*l^2+3*m1*ze^2);

tr_th = 1;
h_th = .707;
Wn_th = 2.2 / tr_th;
kd_th = 2*h_th*Wn_th/C1/l;
kp_th = Wn_th^2/(C1*l);

tr_z = 5; %3.8*tr_th;
h = .707;
Wn = 2.2 / tr_z;

K = -Wn^2/9.81;
a = -K / ((1*h*Wn*1.5+.1)/(1.5*9.81));
K = -.0197;
% K = -.022;
a = .3;

G1 = tf([kp_th*C1*l],[1 C1*l*kd_th C1*l*kp_th]);
G2 = tf([-g],[1 0 0]);

C = tf([1/a 1],1);
H = tf([K/a 0],1);

figure(1);clf;
rlocus(-C*G1*G2);
hold on
sgrid(.7,[2.2/5 100])
rlocus(-C*G1*G2,-K,'k^')

sys = feedback(K*C*G1*G2,1);
figure(2)
step(sys);