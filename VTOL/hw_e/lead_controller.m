F_param

nG = 1/(P.mc+2*P.mr);
dG = [1 0 0];
G = tf(nG,dG);

z = .5;
p = 4.25;
% nC = [1/z 1];
nC = 1;
dC = [1/p 1];
C = tf(nC,dC);

nH = [1/z 1];
dH = [1/1000 1];
H = tf(nH,dH);

K = 4.645 / p;

% rltool(G,C)
% %%
% M = feedback(C*G,H);
% 
% figure(1); clf;
% rlocus(M)

figure(2); clf;
sys = feedback(K*C*G,H);
step(sys)