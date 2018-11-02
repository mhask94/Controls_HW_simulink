clear;clc
% Get the directory of this script
% p = which(mfilename);
% parentDirectory = fileparts(p);

F_param

zv = 0.5;
zt = 0.5;
h = 0.6;
t = 0:.05:50;
theta = 2*pi;

for i = 1:length(t)
    u(1) = zv*sin(t(i))+1;    
    u(2) = zt*sin(t(i))+1;
    u(3) = h*sin(2*t(i))+1;
    u(4) = theta*sin(t(i)/4);
    u(5) = t(i);

    F_animation(u)
end
% u = [zv zt h theta t(1)];
% F_animation(u)