m1 = 0.35;     % Mass of the ball, kg
m2 = 2.0;      % Mass of the beam, kg
ell = 0.5;    % Length of the beam, m
g = 9.8;       % Gravity, m/s**2
ze = ell/2;
C1 = 3 / (m2*ell^2+3*m1*ze^2);

tr = 1;
h = .707;
Wn = 2.2 / tr;
kd = 2*h*Wn/C1/ell;
kp = Wn^2/(C1*ell);

tr_z = 3.8*tr; % for 8f
h_z = .707;
Wn_z = 2.2/tr_z;
kd_z = -2*h_z*Wn_z/g;
kp_z = -Wn_z^2/g;

nD = -g;
dD = [1 -kd_z*g -kp_z*g 0];
D = -tf(nD,dD);

figure(1); clf;
hold on
rlocus(D);
sgrid(.707,[.22 100]);
hold off
%%
ki = -.005;

nG = [-kp_z*g -ki*g];
dG = [1 -kd_z*g -kp_z*g -ki*g];
sys = tf(nG,dG);

figure(2)
step(sys);
%%
nF = kp;
dF = [m (b+kd) (k+kp)];
F = tf(nF,dF);

figure(3)
step(F);