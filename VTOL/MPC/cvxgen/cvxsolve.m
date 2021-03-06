% Produced by CVXGEN, 2018-11-01 18:58:22 -0400.
% CVXGEN is Copyright (C) 2006-2017 Jacob Mattingley, jem@cvxgen.com.
% The code in this file is Copyright (C) 2006-2017 Jacob Mattingley.
% CVXGEN, or solvers produced by CVXGEN, cannot be used for commercial
% applications without prior written permission from Jacob Mattingley.

% Filename: cvxsolve.m.
% Description: Solution file, via cvx, for use with sample.m.
function [vars, status] = cvxsolve(params, settings)
A = params.A;
B = params.B;
Wr = params.Wr;
Wy = params.Wy;
Wy_final = params.Wy_final;
r_des_0 = params.r_des_0;
if isfield(params, 'r_des_1')
  r_des_1 = params.r_des_1;
elseif isfield(params, 'r_des')
  r_des_1 = params.r_des{1};
else
  error 'could not find r_des_1'
end
if isfield(params, 'r_des_2')
  r_des_2 = params.r_des_2;
elseif isfield(params, 'r_des')
  r_des_2 = params.r_des{2};
else
  error 'could not find r_des_2'
end
if isfield(params, 'r_des_3')
  r_des_3 = params.r_des_3;
elseif isfield(params, 'r_des')
  r_des_3 = params.r_des{3};
else
  error 'could not find r_des_3'
end
if isfield(params, 'r_des_4')
  r_des_4 = params.r_des_4;
elseif isfield(params, 'r_des')
  r_des_4 = params.r_des{4};
else
  error 'could not find r_des_4'
end
if isfield(params, 'r_des_5')
  r_des_5 = params.r_des_5;
elseif isfield(params, 'r_des')
  r_des_5 = params.r_des{5};
else
  error 'could not find r_des_5'
end
if isfield(params, 'r_des_6')
  r_des_6 = params.r_des_6;
elseif isfield(params, 'r_des')
  r_des_6 = params.r_des{6};
else
  error 'could not find r_des_6'
end
if isfield(params, 'r_des_7')
  r_des_7 = params.r_des_7;
elseif isfield(params, 'r_des')
  r_des_7 = params.r_des{7};
else
  error 'could not find r_des_7'
end
if isfield(params, 'r_des_8')
  r_des_8 = params.r_des_8;
elseif isfield(params, 'r_des')
  r_des_8 = params.r_des{8};
else
  error 'could not find r_des_8'
end
if isfield(params, 'r_des_9')
  r_des_9 = params.r_des_9;
elseif isfield(params, 'r_des')
  r_des_9 = params.r_des{9};
else
  error 'could not find r_des_9'
end
if isfield(params, 'r_des_10')
  r_des_10 = params.r_des_10;
elseif isfield(params, 'r_des')
  r_des_10 = params.r_des{10};
else
  error 'could not find r_des_10'
end
r_max = params.r_max;
r_min = params.r_min;
x_0 = params.x_0;
x_des_0 = params.x_des_0;
if isfield(params, 'x_des_1')
  x_des_1 = params.x_des_1;
elseif isfield(params, 'x_des')
  x_des_1 = params.x_des{1};
else
  error 'could not find x_des_1'
end
if isfield(params, 'x_des_2')
  x_des_2 = params.x_des_2;
elseif isfield(params, 'x_des')
  x_des_2 = params.x_des{2};
else
  error 'could not find x_des_2'
end
if isfield(params, 'x_des_3')
  x_des_3 = params.x_des_3;
elseif isfield(params, 'x_des')
  x_des_3 = params.x_des{3};
else
  error 'could not find x_des_3'
end
if isfield(params, 'x_des_4')
  x_des_4 = params.x_des_4;
elseif isfield(params, 'x_des')
  x_des_4 = params.x_des{4};
else
  error 'could not find x_des_4'
end
if isfield(params, 'x_des_5')
  x_des_5 = params.x_des_5;
elseif isfield(params, 'x_des')
  x_des_5 = params.x_des{5};
else
  error 'could not find x_des_5'
end
if isfield(params, 'x_des_6')
  x_des_6 = params.x_des_6;
elseif isfield(params, 'x_des')
  x_des_6 = params.x_des{6};
else
  error 'could not find x_des_6'
end
if isfield(params, 'x_des_7')
  x_des_7 = params.x_des_7;
elseif isfield(params, 'x_des')
  x_des_7 = params.x_des{7};
else
  error 'could not find x_des_7'
end
if isfield(params, 'x_des_8')
  x_des_8 = params.x_des_8;
elseif isfield(params, 'x_des')
  x_des_8 = params.x_des{8};
else
  error 'could not find x_des_8'
end
if isfield(params, 'x_des_9')
  x_des_9 = params.x_des_9;
elseif isfield(params, 'x_des')
  x_des_9 = params.x_des{9};
else
  error 'could not find x_des_9'
end
if isfield(params, 'x_des_10')
  x_des_10 = params.x_des_10;
elseif isfield(params, 'x_des')
  x_des_10 = params.x_des{10};
else
  error 'could not find x_des_10'
end
if isfield(params, 'x_des_11')
  x_des_11 = params.x_des_11;
elseif isfield(params, 'x_des')
  x_des_11 = params.x_des{11};
else
  error 'could not find x_des_11'
end
cvx_begin
  % Caution: automatically generated by cvxgen. May be incorrect.
  variable r_0(2, 1);
  variable x_1(6, 1);
  variable r_1(2, 1);
  variable x_2(6, 1);
  variable r_2(2, 1);
  variable x_3(6, 1);
  variable r_3(2, 1);
  variable x_4(6, 1);
  variable r_4(2, 1);
  variable x_5(6, 1);
  variable r_5(2, 1);
  variable x_6(6, 1);
  variable r_6(2, 1);
  variable x_7(6, 1);
  variable r_7(2, 1);
  variable x_8(6, 1);
  variable r_8(2, 1);
  variable x_9(6, 1);
  variable r_9(2, 1);
  variable x_10(6, 1);
  variable r_10(2, 1);
  variable x_11(6, 1);

  minimize(quad_form(x_0 - x_des_0, Wy) + quad_form(r_0 - r_des_0, Wr) + quad_form(x_1 - x_des_1, Wy) + quad_form(r_1 - r_des_1, Wr) + quad_form(x_2 - x_des_2, Wy) + quad_form(r_2 - r_des_2, Wr) + quad_form(x_3 - x_des_3, Wy) + quad_form(r_3 - r_des_3, Wr) + quad_form(x_4 - x_des_4, Wy) + quad_form(r_4 - r_des_4, Wr) + quad_form(x_5 - x_des_5, Wy) + quad_form(r_5 - r_des_5, Wr) + quad_form(x_6 - x_des_6, Wy) + quad_form(r_6 - r_des_6, Wr) + quad_form(x_7 - x_des_7, Wy) + quad_form(r_7 - r_des_7, Wr) + quad_form(x_8 - x_des_8, Wy) + quad_form(r_8 - r_des_8, Wr) + quad_form(x_9 - x_des_9, Wy) + quad_form(r_9 - r_des_9, Wr) + quad_form(x_10 - x_des_10, Wy) + quad_form(r_10 - r_des_10, Wr) + quad_form(x_des_11 - x_11, Wy_final));
  subject to
    x_1 == A*x_0 + B*(r_0 - r_des_0);
    x_2 == A*x_1 + B*(r_1 - r_des_1);
    x_3 == A*x_2 + B*(r_2 - r_des_2);
    x_4 == A*x_3 + B*(r_3 - r_des_3);
    x_5 == A*x_4 + B*(r_4 - r_des_4);
    x_6 == A*x_5 + B*(r_5 - r_des_5);
    x_7 == A*x_6 + B*(r_6 - r_des_6);
    x_8 == A*x_7 + B*(r_7 - r_des_7);
    x_9 == A*x_8 + B*(r_8 - r_des_8);
    x_10 == A*x_9 + B*(r_9 - r_des_9);
    x_11 == A*x_10 + B*(r_10 - r_des_10);
    r_min <= r_0;
    r_min <= r_1;
    r_min <= r_2;
    r_min <= r_3;
    r_min <= r_4;
    r_min <= r_5;
    r_min <= r_6;
    r_min <= r_7;
    r_min <= r_8;
    r_min <= r_9;
    r_min <= r_10;
    r_0 <= r_max;
    r_1 <= r_max;
    r_2 <= r_max;
    r_3 <= r_max;
    r_4 <= r_max;
    r_5 <= r_max;
    r_6 <= r_max;
    r_7 <= r_max;
    r_8 <= r_max;
    r_9 <= r_max;
    r_10 <= r_max;
cvx_end
vars.r_0 = r_0;
vars.r_1 = r_1;
vars.r{1} = r_1;
vars.r_2 = r_2;
vars.r{2} = r_2;
vars.r_3 = r_3;
vars.r{3} = r_3;
vars.r_4 = r_4;
vars.r{4} = r_4;
vars.r_5 = r_5;
vars.r{5} = r_5;
vars.r_6 = r_6;
vars.r{6} = r_6;
vars.r_7 = r_7;
vars.r{7} = r_7;
vars.r_8 = r_8;
vars.r{8} = r_8;
vars.r_9 = r_9;
vars.r{9} = r_9;
vars.r_10 = r_10;
vars.r{10} = r_10;
vars.x_1 = x_1;
vars.x{1} = x_1;
vars.x_2 = x_2;
vars.x{2} = x_2;
vars.x_3 = x_3;
vars.x{3} = x_3;
vars.x_4 = x_4;
vars.x{4} = x_4;
vars.x_5 = x_5;
vars.x{5} = x_5;
vars.x_6 = x_6;
vars.x{6} = x_6;
vars.x_7 = x_7;
vars.x{7} = x_7;
vars.x_8 = x_8;
vars.x{8} = x_8;
vars.x_9 = x_9;
vars.x{9} = x_9;
vars.x_10 = x_10;
vars.x{10} = x_10;
vars.x_11 = x_11;
vars.x{11} = x_11;
status.cvx_status = cvx_status;
% Provide a drop-in replacement for csolve.
status.optval = cvx_optval;
status.converged = strcmp(cvx_status, 'Solved');
