% in = inputs.signals.values;
% out = outputs.signals.values;
th = theta.signals.values;
tau = Tau.signals.values;
th_c = theta_c.signals.values;
thd = thetad.signals.values;

% acc_z = -(P.mu*out(:,4)+in(:,1)*sin(out(:,2)))/P.M;
acc_theta = tau / P.J;

% test filter
f = [th-th_c, thd];
d = -acc_theta;
h_hat = [0;0];
del = 0.1;
Pm = eye(length(h_hat))/del;
q = [0;0];

for i = 1:length(f)
    q = f(i,:)';
    K = Pm*q/(1+q'*Pm*q);
    e = d(i)-q'*h_hat;
    h_hat = h_hat+K*e;
    Pm = Pm - K*q'*Pm;
end

h_hat
e