% Part a
tr_th = 1;
Wn_th = 2.2/tr_th;
h_th = .707;
tr_z = 3.8*tr_th;
Wn_z = 2.2/tr_z;
h_z = .707;

des_char_poly = conv([1 2*Wn_z*h_z Wn_z^2],[1 2*Wn_th*h_th Wn_th^2]);
p = roots(des_char_poly)

% Part b
A = [0 0 1 0;0 0 0 1;0 -9.8 0 0;-18.1923 0 0 0];
B = [0;0;0;2.6519];
C = [1 0 0 0; 0 1 0 0];
D = [0;0];
Cr = C(1,:);

% sys = ss(A,B,C,D)

% Part c
C_ab = [B A*B A*A*B A*A*A*B];
if rank(C_ab) ~= 4
    'Warning: Not Controllable'
end

% Part d
K = place(A,B,p)
kr = -1 / (Cr*inv(A-B*K)*B)

%% Part e (tune response)
R1 = -3.25;
I1 = 3.1i;
R2 = -3.0;
I2 = 2.75i;
des_p = [R1 + I1;R1 - I1;R2 + I2;R2 - I2];

K = place(A,B,des_p)
kr = -1 / (Cr*inv(A-B*K)*B)