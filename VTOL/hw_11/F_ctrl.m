function u = F_ctrl(in)
r_h = in(1);
r_z = in(2);
x_lon = [in(4);in(7)];
x_lat = [in(3);in(5);in(6);in(8)];

x_lon_e = [0;0];
x_lat_e = [0;0;0;0];
x_lon_tilde = x_lon - x_lon_e;
x_lat_tilde = x_lat - x_lat_e;

r_z_e = 0;
r_h_e = 0;
r_z_tilde = r_z - r_z_e;
r_h_tilde = r_h - r_h_e;

u_z_e = 0;
u_h_e = 9.81*1.5;

% K_h = [4.6167    3.5082];
% kr_h = 4.6167;
K_h = [8.3333    5.3333];
kr_h = K_h(1);

u_h_tilde = -K_h*x_lon_tilde + kr_h*r_h_tilde;
u_h = u_h_e + u_h_tilde;

% K_z = [-0.0586    0.7655   -0.0916    0.2742];
% kr_z = -0.0586;
K_z = [-0.1668    1.3743   -0.2261    0.3898];
kr_z = K_z(1);

u_z_tilde = -K_z*x_lat_tilde + kr_z*r_z_tilde;
u_z = u_z_e + u_z_tilde;

u = [u_h;u_z];
end