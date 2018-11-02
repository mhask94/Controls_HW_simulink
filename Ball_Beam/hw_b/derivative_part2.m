syms F z m1 m2 L g
th = 0;thd = 0;zd = 0;%m1=.35;m2=2;L=.5;g=9.8;z=L/2;F=.5*m2*g+m1*g*z/L;

((2*m1*z*(2*m1*thd*z*zd - (.5*m2*g+m1*g*z/L)*L*cos(th) + (L*g*m1*cos(th))/2 + ...
    g*m1*z*cos(th)))/((m2*L^2)/3 + m1*z^2)^2 - (g*m1*cos(th) + ...
    2*m1*thd*zd)/((m2*L^2)/3 + m1*z^2))

-m1*g/(m1*z^2+1/3*m2*L^2)

-(3*g*m1*(L^2*m2 + 3*m1*z^2 - 3*L*m1*z + 3*L*m2*z))/(m2*L^2 + 3*m1*z^2)^2