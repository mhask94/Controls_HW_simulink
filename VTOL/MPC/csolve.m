% csolve  Solves a custom quadratic program very rapidly.
%
% [vars, status] = csolve(params, settings)
%
% solves the convex optimization problem
%
%   minimize(quad_form(x_0 - x_des_0, Wy) + quad_form(r_0 - r_des_0, Wr) + quad_form(x_1 - x_des_1, Wy) + quad_form(r_1 - r_des_1, Wr) + quad_form(x_2 - x_des_2, Wy) + quad_form(r_2 - r_des_2, Wr) + quad_form(x_3 - x_des_3, Wy) + quad_form(r_3 - r_des_3, Wr) + quad_form(x_4 - x_des_4, Wy) + quad_form(r_4 - r_des_4, Wr) + quad_form(x_5 - x_des_5, Wy) + quad_form(r_5 - r_des_5, Wr) + quad_form(x_6 - x_des_6, Wy) + quad_form(r_6 - r_des_6, Wr) + quad_form(x_7 - x_des_7, Wy) + quad_form(r_7 - r_des_7, Wr) + quad_form(x_8 - x_des_8, Wy) + quad_form(r_8 - r_des_8, Wr) + quad_form(x_9 - x_des_9, Wy) + quad_form(r_9 - r_des_9, Wr) + quad_form(x_10 - x_des_10, Wy) + quad_form(r_10 - r_des_10, Wr) + quad_form(x_des_11 - x_11, Wy_final))
%   subject to
%     x_1 == A*x_0 + B*(r_0 - r_des_0)
%     x_2 == A*x_1 + B*(r_1 - r_des_1)
%     x_3 == A*x_2 + B*(r_2 - r_des_2)
%     x_4 == A*x_3 + B*(r_3 - r_des_3)
%     x_5 == A*x_4 + B*(r_4 - r_des_4)
%     x_6 == A*x_5 + B*(r_5 - r_des_5)
%     x_7 == A*x_6 + B*(r_6 - r_des_6)
%     x_8 == A*x_7 + B*(r_7 - r_des_7)
%     x_9 == A*x_8 + B*(r_8 - r_des_8)
%     x_10 == A*x_9 + B*(r_9 - r_des_9)
%     x_11 == A*x_10 + B*(r_10 - r_des_10)
%     r_min <= r_0
%     r_min <= r_1
%     r_min <= r_2
%     r_min <= r_3
%     r_min <= r_4
%     r_min <= r_5
%     r_min <= r_6
%     r_min <= r_7
%     r_min <= r_8
%     r_min <= r_9
%     r_min <= r_10
%     r_0 <= r_max
%     r_1 <= r_max
%     r_2 <= r_max
%     r_3 <= r_max
%     r_4 <= r_max
%     r_5 <= r_max
%     r_6 <= r_max
%     r_7 <= r_max
%     r_8 <= r_max
%     r_9 <= r_max
%     r_10 <= r_max
%
% with variables
%      r_0   2 x 1
%      r_1   2 x 1
%      r_2   2 x 1
%      r_3   2 x 1
%      r_4   2 x 1
%      r_5   2 x 1
%      r_6   2 x 1
%      r_7   2 x 1
%      r_8   2 x 1
%      r_9   2 x 1
%     r_10   2 x 1
%      x_1   6 x 1
%      x_2   6 x 1
%      x_3   6 x 1
%      x_4   6 x 1
%      x_5   6 x 1
%      x_6   6 x 1
%      x_7   6 x 1
%      x_8   6 x 1
%      x_9   6 x 1
%     x_10   6 x 1
%     x_11   6 x 1
%
% and parameters
%        A   6 x 6
%        B   6 x 2
%       Wr   2 x 2    PSD, diagonal
%       Wy   6 x 6    PSD, diagonal
% Wy_final   6 x 6    PSD, diagonal
%  r_des_0   2 x 1
%  r_des_1   2 x 1
%  r_des_2   2 x 1
%  r_des_3   2 x 1
%  r_des_4   2 x 1
%  r_des_5   2 x 1
%  r_des_6   2 x 1
%  r_des_7   2 x 1
%  r_des_8   2 x 1
%  r_des_9   2 x 1
% r_des_10   2 x 1
%    r_max   2 x 1    positive
%    r_min   2 x 1
%      x_0   6 x 1
%  x_des_0   6 x 1
%  x_des_1   6 x 1
%  x_des_2   6 x 1
%  x_des_3   6 x 1
%  x_des_4   6 x 1
%  x_des_5   6 x 1
%  x_des_6   6 x 1
%  x_des_7   6 x 1
%  x_des_8   6 x 1
%  x_des_9   6 x 1
% x_des_10   6 x 1
% x_des_11   6 x 1
%
% Note:
%   - Check status.converged, which will be 1 if optimization succeeded.
%   - You don't have to specify settings if you don't want to.
%   - To hide output, use settings.verbose = 0.
%   - To change iterations, use settings.max_iters = 20.
%   - You may wish to compare with cvxsolve to check the solver is correct.
%
% Specify params.A, ..., params.x_des_11, then run
%   [vars, status] = csolve(params, settings)
% Produced by CVXGEN, 2018-11-01 18:58:22 -0400.
% CVXGEN is Copyright (C) 2006-2017 Jacob Mattingley, jem@cvxgen.com.
% The code in this file is Copyright (C) 2006-2017 Jacob Mattingley.
% CVXGEN, or solvers produced by CVXGEN, cannot be used for commercial
% applications without prior written permission from Jacob Mattingley.

% Filename: csolve.m.
% Description: Help file for the Matlab solver interface.
