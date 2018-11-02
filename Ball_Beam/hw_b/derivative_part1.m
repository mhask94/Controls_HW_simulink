syms F L th z m1 m2 zd thd g 
func = (F*L*cos(th)-2*m1*z*zd*thd-m1*g*z*cos(th)-.5*m1*g*L*cos(th))/...
    (m2*L^2/3+m1*z^2);

eq = diff(func,z);

seq = simplify(eq);
simplify(seq)
%%
syms L z m1 m2 g 
th = 0;zd = 0; thd = 0;
equation = (2*m1*z*(2*m1*thd*z*zd - (.5*m2*g*L+m1*g*z)*L*cos(th) + (L*g*m1*cos(th))/2 + g*m1*z*cos(th)))/((m2*L^2)/3 + m1*z^2)^2 - (g*m1*cos(th) + 2*m1*thd*zd)/((m2*L^2)/3 + m1*z^2)
