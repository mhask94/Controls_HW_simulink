function u = F_ctrl(in)
r_h = in(1);
r_z = in(2);
x_lon = [in(4);in(7)];
x_lat = [in(3);in(5);in(6);in(8)];
t = in(9);
Ts = 0.01;

x_lon_e = [0;0];
x_lat_e = [0;0;0;0];
x_lon_tilde = x_lon - x_lon_e;
x_lat_tilde = x_lat - x_lat_e;

r_z_e = 0;
r_h_e = 0;
% r_lat_tilde = r_z - r_z_e;
% r_lon_tilde = r_h - r_h_e;

u_lat_e = 0;
u_lon_e = 9.81*1.5;

persistent integrator_lon
persistent error_d1_lon
persistent integrator_lat
persistent error_d1_lat
if t < 3.0
    integrator_lon = 0;
    error_d1_lon = 0;
    integrator_lat = 0;
    error_d1_lat = 0;
end
error_lon = r_h - x_lon(1);
error_lat = r_z - x_lat(1);
integrator_lon = integrator_lon + (Ts/2)*(error_lon+error_d1_lon);
integrator_lat = integrator_lat + (Ts/2)*(error_lat+error_d1_lat);
error_d1_lon = error_lon;
error_d1_lat = error_lat;

% K_lon = [9.4000    5.6000];
% ki_lon = -1.6667;
K_lon = [11     6];
ki_lon = -4.1667;

u_lon_tilde = -K_lon*(x_lon_tilde-x_lon_e) - ki_lon*integrator_lon;
u_unsat_lon = u_lon_e + u_lon_tilde;
u_lon = sat(u_unsat_lon,25);

% K_lat = [-0.2139    1.4523   -0.2541    0.3996];
% ki_lat = 0.0334;
K_lat = [-0.2845    1.5692   -0.2961    0.4144];
ki_lat = 0.0834;

u_lat_tilde = -K_lat*(x_lat_tilde-x_lat_e) - ki_lat*integrator_lat;
u_unsat_lat = u_lat_e + u_lat_tilde;
u_lat = sat(u_unsat_lat,5);

% Integrator anti-windup
if ki_lat ~= 0 && ki_lon ~= 0
    integrator_lat = sat(integrator_lat + Ts/ki_lat * (u_lat-u_unsat_lat),18); % 17
    integrator_lon = integrator_lon + Ts/ki_lon * (u_lon-u_unsat_lon);
end

u = [u_lon;u_lat];
end

function out = sat(in,limit)
    if abs(in) > limit
        out = limit*sign(in);
    else
        out = in;
    end
end