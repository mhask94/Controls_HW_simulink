% Physical parameters of the VTOL known to the controller
clear P
mc = 1.0;      % Mass of the center, kg
mr = 0.25;     % Mass of the right prop, kg
Jc = .0042;    % Inertia of center
P.d = 0.3;       % Distance from center to mid-prop, m
P.g = 9.81;      % Gravity, m/s**2
P.mu = 0.1;      % Viscosity?, kg/s
P.M = mc+2*mr;
P.J = Jc + 2*mr*P.d^2;
clear mc mr Jc

% parameters for animation
P.h = 0.05;      % Height of the beam, m
P.gap = 0.1;   % Gap between the cart and x-axis
P.radius = 0.06; % Radius of circular part of pendulum
P.l_lim = -.05;    % Lower limit of graph axes
P.u_lim = 2;    % Upper limit of graph axes
P.bl = .13;      % Body length of center, m
P.a = .08;        % Prop length, m
P.b = .02;       % Prop height, m

% Initial Conditions
P.zv0 = 0.5;                % initial cart position, m
P.zt0 = 0.0;                % initial cart position, m
P.h0 = 0.0;                % initial cart position, m
P.theta0 = 0.0*pi/180;     % initial rod angle, rads
P.zvd0 = 0.0;             % initial cart velocity, m/s
P.ztd0 = 0.0;             % initial cart velocity, m/s
P.hd0 = 0.0;             % initial cart velocity, m/s
P.thetad0 = 0.0;         % initial rod angular velocity, rads/s

% Simulation Parameters
P.t_start = 0.0;  % Start time of simulation
P.t_end = 50.0;   % End time of simulation
P.Ts = 0.01;      % sample time for simulation
P.t_plot = 0.05;   % the plotting and animation is updated at this rate

% Longitudinal Gains
tr_height = 1.1823;
Wn_height = 2.2/tr_height;
h_height = .707;
P.kph = Wn_height^2*P.M;
P.kdh = 2*h_height*Wn_height*P.M;
clear tr_height Wn_height h_height

% Lateral Gains
tr_theta = .4; % was .8 s
Wn_theta = 2.2/tr_theta;
h_theta = .707;
P.kptheta = Wn_theta^2*P.J;
P.kdtheta = 2*h_theta*Wn_theta*P.J;
% P.kptheta = 1.3743;
% P.kdtheta = 0.3898;

tr_z = 2.21*tr_theta;
Wn_z = 2.2/tr_z;
h_z = .707;
P.kpz = -Wn_z^2/P.g;
P.kdz = (-2*h_z*Wn_z*P.M+P.mu)/(P.M*P.g);
clear tr_theta Wn_theta h_theta
clear tr_z Wn_z h_z

P.ts = .01;

% Lateral only
% A = [0 0 1 0;0 0 0 1;0 -P.g -P.mu/P.M 0;0 -P.kptheta/P.J 0 -P.kdtheta/P.J];
% B = [0;0;0;P.kptheta/P.J];

% Lateral and Longitude
% A = [zeros(3),eye(3);0 -P.g 0 -P.mu/P.M 0 0;0 -P.kptheta/P.J 0 0 -P.kdtheta/P.J 0;zeros(1,6)];
% B = zeros(6,2); B(5,2)=P.kptheta/P.J; B(6,1)=1/P.M; 
A = [zeros(3),eye(3);0 -P.g 0 -P.mu/P.M 0 0;0 -96.8665 0 0 -269.5942 0;zeros(1,6)];
B = zeros(6,2); B(5,2)=96.8665; B(6,1)=1/P.M; 

C = eye(length(A));
D = zeros(length(C(:,1)),length(B(1,:)));

sys = ss(A,B,C,D);
sys_d = c2d(sys,P.ts);
[P.Ad,P.Bd,P.Cd,P.Dd] = ssdata(sys_d);
clear sys sys_d A B C D