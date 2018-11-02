%% longitudinal

% Part a
tr_h = 1.1823;
Wn_h = 2.2/tr_h;
h_h = .707;


des_char_poly_lon = [1 2*Wn_h*h_h Wn_h^2];
p = roots(des_char_poly_lon)

% Part b
A = [0 1;0 0];
B = [0; 0.75];
C = [1 0];
D = [0];

% sys = ss(A,B,C,D)

% Part c
C_ab = [B A*B];
if rank(C_ab) ~= 2
    'Warning: Not Controllable'
end

% Part d
K_h = place(A,B,p)
Cr = [1 0];
kr_h = -1 / (Cr*inv(A-B*K_h)*B)

% Part e (tune response)
R1 = -2.0;
I1 = 1.5i;
des_p = [R1 + I1;R1 - I1];

K_h = place(A,B,des_p)
kr_h = -1 / (Cr*inv(A-B*K_h)*B)

%% lateral

% Part a
tr_th = 0.8;
Wn_th = 2.2/tr_th;
h_th = .707;
tr_z = 1.768;
Wn_z = 2.2/tr_z;
h_z = .707;

des_char_poly_lat = conv([1 2*Wn_z*h_z Wn_z^2],[1 2*Wn_th*h_th Wn_th^2]);
p = roots(des_char_poly_lat)

% Part b
A = [0 0 1 0;0 0 0 1;0 -9.81 -.0666667 0;0 0 0 0];
B = [0;0;0;20.3525];
C = [1 0 0 0; 0 1 0 0];
D = [0;0];

% sys = ss(A,B,C,D)

% Part c
C_ab = [B A*B A^2*B A^3*B];
if rank(C_ab) ~= 4
    'Warning: Not Controllable'
end

% Part d
K_z = place(A,B,p)
Cr = [1 0 0 0];
kr_z = -1 / (Cr*inv(A-B*K_z)*B)

% Part e (tune response)
R1 = -2.5;
I1 = 2.0i;
R2 = -1.5;
I2 = 1.0i;
des_p = [R1 + I1;R1 - I1;R2 + I2;R2 - I2];

K_z = place(A,B,des_p)
kr_z = -1 / (Cr*inv(A-B*K_z)*B)