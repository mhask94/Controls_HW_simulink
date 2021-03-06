% Physical parameters of the inverted pendulum known to the controller
P.m1 = 0.35;     % Mass of the ball, kg
P.m2 = 2.0;      % Mass of the beam, kg
P.ell = 0.5;    % Length of the beam, m
P.g = 9.8;       % Gravity, m/s**2
% P.b = 0.05;      % Damping coefficient, Ns

% parameters for animation
P.h = 0.05;      % Height of the beam, m
P.gap = 0.089;   % Gap between the cart and x-axis
P.radius = 0.06; % Radius of circular part of pendulum
P.l_lim = -1;    % Lower limit of graph axes
P.u_lim = 1;    % Upper limit of graph axes

% Initial Conditions
P.z0 = P.ell/2;            % initial cart position, m
P.theta0 = 0.0*pi/180;     % initial rod angle, rads
P.zdot0 = 0.0;             % initial cart velocity, m/s
P.thetadot0 = 0.0;         % initial rod angular velocity, rads/s

% Simulation Parameters
P.t_start = 0.0;  % Start time of simulation
P.t_end = 50.0;   % End time of simulation
P.Ts = 0.01;      % sample time for simulation
P.t_plot = 0.1;   % the plotting and animation is updated at this rate

% Inner Loop Gains
ze = P.ell/2;
C1 = 3 / (P.m2*P.ell^2+3*P.m1*ze^2);
tr_th = 1;
h_th = .707;
Wn_th = 2.2 / tr_th;
P.kd_th = 2*h_th*Wn_th/C1/P.ell;
P.kp_th = Wn_th^2/(C1*P.ell);

% Outer Loop Gains
% tr_z = 10.0*tr_th;  % for 8e
tr_z = 3.8*tr_th; % for 8f
h_z = .707;
Wn_z = 2.2/tr_z;
P.kd_z = -2*h_z*Wn_z/P.g;
P.kp_z = -Wn_z^2/P.g;

% State-Space Control
% A = [0 0 1 0;0 0 0 1;0 -9.8 0 0;-18.1923 0 0 0];
% B = [0;0;0;2.6519];
% Cr = [1 0 0 0];
% 
% R1 = -2.0;
% I1 = 1.7i;
% R2 = -0.5;
% I2 = 0.5i;
% des_p = [R1 + I1;R1 - I1;R2 + I2;R2 - I2];
% 
% P.K = place(A,B,des_p);
% P.kr = -1 / (Cr*inv(A-B*K)*B);