function u = F_ctrl(in)
r_h = in(1);
r_z = in(2);
x_lon_m = in(4);
x_lat_m = [in(3);in(5)];
t = in(6);
Ts = 0.01;

x_lon_e = [0;0];
x_lat_e = [0;0;0;0];

u_lat_e = 0;
u_lon_e = 9.81*1.5;

% Implement observer
persistent xhat_lon
persistent force
persistent xhat_lat
persistent tau
if t < .01
    xhat_lon = [1;0];
    force = 0;
    xhat_lat = [0;0;0;0];
    tau = 0;
end

% Euler integration version
xhat_lon = eulerIntegration_lon(xhat_lon,x_lon_e,force,u_lon_e,x_lon_m);
xhat_lat = eulerIntegration_lat(xhat_lat,x_lat_e,tau,u_lat_e,x_lat_m);

persistent integrator_lon
persistent error_d1_lon
persistent integrator_lat
persistent error_d1_lat
if t < 0.1
    integrator_lon = 0;
    error_d1_lon = 0;
    integrator_lat = 0;
    error_d1_lat = 0;
end
error_lon = r_h - x_lon_m(1);
error_lat = r_z - x_lat_m(1);
integrator_lon = integrator_lon + (Ts/2)*(error_lon+error_d1_lon);
integrator_lat = integrator_lat + (Ts/2)*(error_lat+error_d1_lat);
error_d1_lon = error_lon;
error_d1_lat = error_lat;

K_lon = [27.5467    8.2667];
ki_lon = -23.4560;
% K_lon = [26.2133    8.0000];
% ki_lon = -19.5467;

u_lon_tilde = -K_lon*xhat_lon - ki_lon*integrator_lon;
u_unsat_lon = u_lon_e + u_lon_tilde;
u_lon = sat(u_unsat_lon,25);

K_lat = [-0.6294    1.9764   -0.4669    0.4389];
ki_lat = 0.3134;
% K_lat = [-0.2845    1.5692   -0.2961    0.4144];
% ki_lat = 0.0834;

u_lat_tilde = -K_lat*xhat_lat - ki_lat*integrator_lat;
u_unsat_lat = u_lat_e + u_lat_tilde;
u_lat = sat(u_unsat_lat,5);

% Integrator anti-windup
if ki_lat ~= 0 && ki_lon ~= 0
    integrator_lat = sat(integrator_lat + Ts/ki_lat * (u_lat-u_unsat_lat),18); % 17
    integrator_lon = integrator_lon + Ts/ki_lon * (u_lon-u_unsat_lon);
end

u = [u_lon;u_lat;xhat_lon;xhat_lat];
end

function out = sat(in,limit)
    if abs(in) > limit
        out = limit*sign(in);
    else
        out = in;
    end
end

function out = eulerIntegration_lon(xhat,x_e,u,u_e,y_m)
    N = 10;
    Ts = .01;   % make sure to match with P.Ts in E_param.m
    A = [0 1;0 0];
    B = [0;0.75];
    C = [1 0];
    L = [40.0000; 625.0000];
    for i = 1:N
        xhat = xhat + (Ts/N) * (A*(xhat-x_e) + B*(u-u_e) + L*(y_m-C*(xhat)));
    end
    out = xhat;
end

function out = eulerIntegration_lat(xhat,x_e,u,u_e,y_m)
    N = 10;
    Ts = .01;   % make sure to match with P.Ts in E_param.m
    A = [0 0 1 0;0 0 0 1;0 -9.81 -.0666667 0;0 0 0 0];
    B = [0;0;0;20.3525];
    C = [1 0 0 0;0 1 0 0];
    L = [39.9017,-9.9968;10.0030,40.0317;571.1868,-59.5520;49.5878,576.1561];
    for i = 1:N
        xhat = xhat + (Ts/N) * (A*(xhat-x_e) + B*(u-u_e) + L*(y_m-C*(xhat)));
    end
    out = xhat;
end