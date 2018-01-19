clear;clc
% Get the directory of this script
% p = which(mfilename);
% parentDirectory = fileparts(p);

% F_param

zv = 1.0;
zt = 1.0;
h = 1.0;
theta = 30.0*pi/180;
t = 0:.1:50;

u(1) = zv;    
u(2) = zt;
u(3) = h;
u(4) = theta;
u(5) = t(1);

F_animation(u)