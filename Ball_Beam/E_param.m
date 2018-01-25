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
P.z0 = P.ell/2;                % initial cart position, m
P.theta0 = 0.0*pi/180;     % initial rod angle, rads
P.zdot0 = 0.0;             % initial cart velocity, m/s
P.thetadot0 = 0.0;         % initial rod angular velocity, rads/s

% Simulation Parameters
P.t_start = 0.0;  % Start time of simulation
P.t_end = 50.0;   % End time of simulation
P.Ts = 0.01;      % sample time for simulation
P.t_plot = 0.1;   % the plotting and animation is updated at this rate
