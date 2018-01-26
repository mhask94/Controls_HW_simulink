syms F L th z m1 m2 zd thd g 
func = (F*L*cos(th)-2*m1*z*zd*thd-m1*g*z*cos(th)-.5*m1*g*L*cos(th))/...
    (m2*L^2/3+m1*z^2);

simplify(diff(func,z))