% Physical parameters of the VTOL known to the controller
P.ml = 0.25;     % Mass of the left prop, kg
P.mc = 1.0;      % Mass of the center, kg
P.mr = 0.25;     % Mass of the right prop, kg
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
P.zv0 = 0.5;                % initial cart position, m
P.zt0 = 1.0;                % initial cart position, m
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
P.kph = Wn_height^2*(P.mc+2*P.mr);
P.kdh = 2*h_height*Wn_height*(P.mc+2*P.mr);

% Lateral Gains
tr_theta = .8;
Wn_theta = 2.2/tr_theta;
h_theta = .707;
P.kptheta = Wn_theta^2*(P.Jc+2*P.mr*P.d^2);
P.kdtheta = 2*h_theta*Wn_theta*(P.Jc+2*P.mr*P.d^2);

tr_z = 2.21*tr_theta;
Wn_z = 2.2/tr_z;
h_z = .707;
P.kpz = -Wn_z^2/P.g;
P.kdz = (-2*h_z*Wn_z*(P.mc+2*P.mr)+P.mu)/((P.mc+2*P.mr)*P.g);