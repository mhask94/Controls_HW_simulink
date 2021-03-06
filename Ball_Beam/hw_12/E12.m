% Part a
tr_th = 1;
Wn_th = 2.2/tr_th;
h_th = .707;
tr_z = 3.8*tr_th;
Wn_z = 2.2/tr_z;
h_z = .707;

des_char_poly = conv([1 2*Wn_z*h_z Wn_z^2],[1 2*Wn_th*h_th Wn_th^2]);
p = roots(des_char_poly)

A = [0 0 1 0;0 0 0 1;0 -9.8 0 0;-18.1923 0 0 0];
B = [0;0;0;2.6519];
C = [1 0 0 0; 0 1 0 0];
D = [0;0];
Cr = C(1,:);

A1 = [A,zeros(4,1);-Cr,0];
B1 = [B;0];

% Check for controllability
C_ab = [B,A*B,A^2*B,A^3*B];
rankC = rank(C_ab);
if rankC ~= 4
    Comment = 'Warning: Not Controllable'
end
detC = det(C_ab); % Another way to check controllability if det ~= 0

C1_ab = [B1,A1*B1,A1^2*B1,A1^3*B1,A1^4*B1];
rankC1 = rank(C1_ab);
if rankC1 ~= 5
    Comment = 'Warning: Not Controllable'
end

R1 = -3.5;
I1 = 3.1i;
R2 = -3.4;
I2 = 3.0i;

p_des = [R1+I1;R1-I1;R2+I2;R2-I2;-0.4];
K1 = place(A1,B1,p_des);
K = K1(1:end-1)
ki = K1(end)