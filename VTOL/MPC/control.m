function u = control(in,P)
r_h = in(1);
r_z = in(2);
% x_lon = [in(4);in(7)];
% x_lat = [in(3);in(5);in(6);in(8)];
x_k = [in(3);in(5);in(4);in(6);in(8);in(7)];

% x_lon_e = [0;0];
% x_lat_e = [0;0;0;0];
% x_lon_tilde = x_lon - x_lon_e;
% x_lat_tilde = x_lat - x_lat_e;

% r_z_e = 0;
% r_h_e = 0;
% r_z_tilde = [r_z;0;0;0] - r_z_e;
% r_h_tilde = r_h - r_h_e;
r_tilde = [r_z;0;r_h;0;0;0];

% u_z_e = 0;
% u_h_e = P.g*P.M;

u_e = [P.g*P.M;0];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Longitude Controller
% K_h = [4.6167    3.5082];
% kr_h = 4.6167;
% K_h = [8.3333    5.3333];
% kr_h = K_h(1);
% 
% u_h_tilde = -K_h*x_lon_tilde + kr_h*r_h_tilde;
% F = u_h_e + u_h_tilde;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Latitude Controller
params.A = P.Ad;
params.B = P.Bd;

params.r_des_0 = u_e;
params.r_des_1 = u_e;
params.r_des_2 = u_e;
params.r_des_3 = u_e;
params.r_des_4 = u_e;
params.r_des_5 = u_e;
params.r_des_6 = u_e;
params.r_des_7 = u_e;
params.r_des_8 = u_e;
params.r_des_9 = u_e;
params.r_des_10 = u_e;

params.x_des_0 = r_tilde;
% params.x_des_1 = [ref_sq(P.z_r.A,0.04,0,t+1*P.ts);ref_sq(1.0,0.05,1.5,t+1*P.ts);0;0;0;0];
% params.x_des_2 = [ref_sq(P.z_r.A,0.04,0,t+2*P.ts);ref_sq(1.0,0.05,1.5,t+2*P.ts);0;0;0;0];
% params.x_des_3 = [ref_sq(P.z_r.A,0.04,0,t+3*P.ts);ref_sq(1.0,0.05,1.5,t+3*P.ts);0;0;0;0];
% params.x_des_4 = [ref_sq(P.z_r.A,0.04,0,t+4*P.ts);ref_sq(1.0,0.05,1.5,t+4*P.ts);0;0;0;0];
% params.x_des_5 = [ref_sq(P.z_r.A,0.04,0,t+5*P.ts);ref_sq(1.0,0.05,1.5,t+5*P.ts);0;0;0;0];
% params.x_des_6 = [ref_sq(P.z_r.A,0.04,0,t+6*P.ts);ref_sq(1.0,0.05,1.5,t+6*P.ts);0;0;0;0];
% params.x_des_7 = [ref_sq(P.z_r.A,0.04,0,t+7*P.ts);ref_sq(1.0,0.05,1.5,t+7*P.ts);0;0;0;0];
% params.x_des_8 = [ref_sq(P.z_r.A,0.04,0,t+8*P.ts);ref_sq(1.0,0.05,1.5,t+8*P.ts);0;0;0;0];
% params.x_des_9 = [ref_sq(P.z_r.A,0.04,0,t+9*P.ts);ref_sq(1.0,0.05,1.5,t+9*P.ts);0;0;0;0];
% params.x_des_10 = [ref_sq(P.z_r.A,0.04,0,t+10*P.ts);ref_sq(1.0,0.05,1.5,t+10*P.ts);0;0;0;0];
% params.x_des_11 = [ref_sq(P.z_r.A,0.04,0,t+11*P.ts);ref_sq(1.0,0.05,1.5,t+11*P.ts);0;0;0;0];
params.x_des_1 = r_tilde;
params.x_des_2 = r_tilde;
params.x_des_3 = r_tilde;
params.x_des_4 = r_tilde;
params.x_des_5 = r_tilde;
params.x_des_6 = r_tilde;
params.x_des_7 = r_tilde;
params.x_des_8 = r_tilde;
params.x_des_9 = r_tilde;
params.x_des_10 = r_tilde;
params.x_des_11 = r_tilde;

params.r_max = [40;pi];
params.r_min = [0;-pi];

params.x_0 = x_k;

params.Wr = diag([0.05;0.05]);
params.Wy = diag([40,1,100,2,0,5]);
params.Wy_final = params.Wy*0;

% Create a new settings structure, with some example settings.
settings.verbose = 1;  % disable output of solver progress w/ 0.
settings.max_iters = 25;  % reduce the maximum iteration count, from 25.
settings.eps = 1e-6;  % reduce the required objective tolerance, from 1e-6.
settings.resid_tol = 1e-4;  % reduce the required residual tolerances, from 1e-4.
[vars,status] = csolve(params,settings);

u = vars.r_0;

% K_z = [-0.0586    0.7655   -0.0916    0.2742];
% kr_z = -0.0586;
% K_z = [-0.1668    1.3743   -0.2261    0.3898];
% kr_z = K_z(1);

% u_z_tilde = -K_z*x_lat_tilde + kr_z*r_z_tilde;
% u_z = u_z_e + u_z_tilde;

% u = [F;theta_c];
end