%% longitudinal
tr_h = 1.1823;
Wn_h = 2.2/tr_h;
h_h = .707;

des_char_poly_lon = [1 2*Wn_h*h_h Wn_h^2];
p = roots(des_char_poly_lon);

A = [0 1;0 0];
B = [0; 0.75];
C = [1 0];
D = [0];

A1 = [A,zeros(2,1);-C,0];
B1 = [B;0];

% Check for controllability
C_ab = [B A*B];
if rank(C_ab) ~= 2
    'Warning: Not Controllable'
end

% Check for observability
C1_ab = [B1,A1*B1,A1*A1*B1];
rankC1 = rank(C1_ab);
if rankC1 ~= 3
    Comment = 'Warning: Not Controllable'
end

% tune response
R1 = -2.0;
I1 = 1.5i;
p = [R1 + I1;R1 - I1];

p_des = [p;-0.5]
K1_h = place(A1,B1,p_des);
K_h = K1_h(1:2)
ki_h = K1_h(3)

%% lateral
tr_th = 0.8;
Wn_th = 2.2/tr_th;
h_th = .707;
tr_z = 1.768;
Wn_z = 2.2/tr_z;
h_z = .707;

des_char_poly_lat = conv([1 2*Wn_z*h_z Wn_z^2],[1 2*Wn_th*h_th Wn_th^2]);
p = roots(des_char_poly_lat);

A = [0 0 1 0;0 0 0 1;0 -9.81 -.0666667 0;0 0 0 0];
B = [0;0;0;20.3525];
C = [1 0 0 0; 0 1 0 0];
D = [0;0];

A1_lat = [A,zeros(4,1);-C(1,:),0];
B1_Lat = [B;0];


% Check for controllability
C_ab = [B A*B A^2*B A^3*B];
if rank(C_ab) ~= 4
    'Warning: Not Controllable'
end

% Check for observability
C1_ab_lat = [B1_Lat,A1_lat*B1_Lat,A1_lat^2*B1_Lat,A1_lat^3*B1_Lat,A1_lat^4*B1_Lat];
rankC1 = rank(C1_ab_lat);
if rankC1 ~= 5
    Comment = 'Warning: Not Controllable'
end

% tune response
R1 = -2.5;
I1 = 2.0i;
R2 = -1.5;
I2 = 1.0i;
p_lat = [R1 + I1;R1 - I1;R2 + I2;R2 - I2];

des_p_lat = [p_lat;-.5];
K1_lat = place(A1_lat,B1_Lat,des_p_lat);
K_lat = K1_lat(1:end-1)
ki_Lat = K1_lat(end)