function out = E_ctrl(in)
z_r = in(1);
z_m = in(2);
theta_m = in(3);
t = in(4);

% Make sure this matches E_param.m, I couldn't figure out how to import it
Ts = 0.01;

x_e = [.25;0;0;0];
u_e = 9.8/2*(0.35+2.0);

% Implement observer
persistent xhat
persistent force
if t < .01
    xhat = [0.25;0;0;0];
    force = 0;
end

% Euler integration version
xhat = eulerIntegration(xhat,x_e,force,u_e,[z_m;theta_m]);

% Difference equation version
% xhat = diff_eq(xhat,x_e,force,u_e,z_m);

% Implement integrator
error = z_r - xhat(1);
persistent integrator
persistent error_d1
if t == 0
    integrator = 0;
    error_d1 = 0;
end
integrator = integrator + (Ts/2)*(error+error_d1);
error_d1 = error;

% State-space control w/ no integrator
% K = [-19.7160 28.5588 -8.7997 4.7136];
% kr = -12.8559;
% u_tilde = -K*x_tilde + kr*r_tilde(1);

% State-space control w/ integrator
K = [-293.4447  116.3392  -78.4309    9.2387];
ki = 288.9929;
% K = [-262.1371  112.0027  -73.1589    9.0501];
% ki = 192.6619;
u_tilde = -K*(xhat-x_e) - ki*integrator;

u_unsat = u_e + u_tilde;
u = sat(u_unsat,15);
force = u;

% Integrator anti-windup
if ki ~= 0
    integrator = integrator + Ts/ki * (u-u_unsat);
end

out = [u;xhat];
end

function out = sat(in,limit)
    if abs(in) > limit
        out = limit*sign(in);
    else
        out = in;
    end
end

function out = eulerIntegration(xhat,x_e,u,u_e,y_m)
    N = 10;
    Ts = .01;   % make sure to match with P.Ts in E_param.m
    A = [0 0 1. 0;0 0 0 1.;0 -9.8 0 0;-18.1923 0 0 0];
    B = [0;0;0;2.6519];
    C = [1 0 0 0;0 1 0 0];
%     L = 1.0e+03*[0.1151 -0.0060;0.0037 0.1149;6.5538 -0.1468;-0.1503 6.5344];
    L = 1.0e+03*[0.1148 -0.0020;0.0068 0.1152;7.0748 0.2919;0.2484 7.0886];
    for i = 1:N
        xhat = xhat + (Ts/N) * (A*(xhat-x_e) + B*(u-u_e) + L*(y_m-C*xhat));
    end
    out = xhat;
end

function out = diff_eq(xhat,x_e,u,u_e,y_m)
    Ad = [1.000000074285225 -4.900000024266509e-04 0.010000000148570 -1.633333336799978e-06;
         -9.096150045047307e-04 1.000000074285225 -3.032050006435331e-06 0.010000000148570;
          2.971409006306624e-05 0.098000001455990 1.000000074285225 -4.900000024266508e-04;
         -0.181923002702838 2.971409006306624e-05 -9.096150045047307e-04 1.000000074285225];
    Bd = [-1.082859167815817e-08;
           1.325950006566566e-04;
          -4.331436675859861e-06;
           0.026519000393994];
    Cd = [1 0 0 0];
    Ld = [0.390592509909750;4.338379497142331;6.776289414182754;13.817432018692749];
    out = Ad*(xhat - x_e)+Bd*(u - u_e)+Ld*(y_m-Cd*xhat);
end