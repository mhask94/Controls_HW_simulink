% Physical parameters of the VTOL known to the controller
P.ml = 0.25;     % Mass of the left prop, kg
P.mc = 1.0;      % Mass of the center, kg
P.m3 = 0.25;     % Mass of the right prop, kg
P.Jc = .0042;    % Inertia of center
P.d = 0.3;       % Distance from center to mid-prop, m
P.g = 9.81;      % Gravity, m/s**2
P.mu = 0.1;      % Viscosity?, kg/s

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
P.z0 = 0.0;                % initial cart position, m
P.theta0 = 0.0*pi/180;     % initial rod angle, rads
P.zdot0 = 0.0;             % initial cart velocity, m/s
P.thetadot0 = 0.0;         % initial rod angular velocity, rads/s

% Simulation Parameters
P.t_start = 0.0;  % Start time of simulation
P.t_end = 50.0;   % End time of simulation
P.Ts = 0.01;      % sample time for simulation
P.t_plot = 0.05;   % the plotting and animation is updated at this rate
