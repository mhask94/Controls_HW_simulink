%% Part b
ml = 0.25;     % Mass of the left prop, kg
mc = 1.0;      % Mass of the center, kg
mr = 0.25;     % Mass of the right prop, kg
Jc = .0042;    % Inertia of center
d = 0.3;       % Distance from center to mid-prop, m
g = 9.81;      % Gravity, m/s**2
mu = 0.1;      % Viscosity?, kg/s
Fe = g*(mc+2*mr);

tr = .7;
h = .707;
Wn = 2.2 / tr;

z_in = tr/2;
p_in = 8*z_in;
z_in = .75;
p_in = 6.6;

G = tf([1/(Jc+2*mr*d^2)],[1 0 0]);
C = tf([1/z_in 1],[1/p_in 1]);
H = tf([1/z_in 1],1);

% rltool(G,C)

K = .0795;

figure(1);clf;
rlocus(C*G);
hold on
sgrid(.7,[Wn 100]);
rlocus(C*G,K,'k^');
% inner_loop = feedback(K*C*G,1);
% step(inner_loop)

%% Part C
tr = 5*.7;
h = .707;
Wn = 2.2 / tr;

z_out = tr/2;
p_out = 8*z_out;
% z_out = .08852;
% p_out = 1.109;
z_out = .1217;
p_out = 1.454;

P = tf(-Fe,[(mc+2*mr) mu 0]);
C = tf([1/z_out 1],[1/p_out 1]);
H = tf([1/z_out 1],1);

K = -.03777*z_out/p_out;
% K = -.020005*z_out/p_out;

% rltool(-inner_loop*P)
figure(1);clf;
% rlocus(-C*inner_loop*P);
% hold on
% sgrid(.7,[Wn 100]);
% rlocus(-C*inner_loop*P,-K,'k^');
outer_loop = feedback(K*C*inner_loop*P,1);
step(outer_loop)