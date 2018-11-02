function u = E_ctrl(in,P)
r = [in(1);0;0;0];
x = [in(2);in(3);in(4);in(5)];
t = in(6);
error = r(1) - x(1);

x_e = [.25;0;0;0];
x_tilde = x - x_e;

persistent integrator
persistent error_d1
if t == 0
    integrator = 0;
    error_d1 = 0;
end
integrator = integrator + (P.Ts/2)*(error+error_d1);
error_d1 = error;

r_e = 0.25;
r_tilde = r - r_e;

u_e = 9.8/2*(0.35+2.0);

% State-space control w/ no integrator
% K = [-19.7160 28.5588 -8.7997 4.7136];
% kr = -12.8559;
% u_tilde = -K*x_tilde + kr*r_tilde(1);

% State-space control w/ integrator
K = [-6.9707 3.2822 -0.2669 1.5760];
ki = 0.0156;
u_tilde = -K*x_tilde - ki*integrator;

u_unsat = u_e + u_tilde;
u = sat(u_unsat);

% Integrator anti-windup
if ki ~= 0
    integrator = integrator + P.Ts/ki * (u-u_unsat);
end

end

function out = sat(in,limit)
    if abs(in) > limit
        out = limit*sign(in);
    else
        out = in;
    end
end