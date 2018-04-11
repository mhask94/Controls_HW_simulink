function u = E_ctrl(in)
r = [in(1);0;0;0];
x = [in(2);in(3);in(4);in(5)];

x_e = [.25;0;0;0];
x_tilde = x - x_e;

r_e = 0.25;
r_tilde = r - r_e;

% A = [0 0 1 0;0 0 0 1;0 -9.8 0 0;-18.1923 0 0 0];
% B = [0;0;0;2.6519];
% Cr = [1 0 0 0];
% 
% R1 = -3.25;
% I1 = 3.1i;
% R2 = -3.0;
% I2 = 2.75i;
% des_p = [R1 + I1;R1 - I1;R2 + I2;R2 - I2];

% K = place(A,B,des_p);
% kr = -1 / (Cr*inv(A-B*K)*B);

u_e = 9.8/2*(0.35+2.0);
K = [-19.7160   28.5588   -8.7997    4.7136];
kr = -12.8559;
u_tilde = -K*x_tilde + kr*r_tilde(1);

u = u_e + u_tilde;
end