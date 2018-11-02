/* Produced by CVXGEN, 2018-11-01 18:58:24 -0400.  */
/* CVXGEN is Copyright (C) 2006-2017 Jacob Mattingley, jem@cvxgen.com. */
/* The code in this file is Copyright (C) 2006-2017 Jacob Mattingley. */
/* CVXGEN, or solvers produced by CVXGEN, cannot be used for commercial */
/* applications without prior written permission from Jacob Mattingley. */

/* Filename: solver.h. */
/* Description: Header file with relevant definitions. */
#ifndef SOLVER_H
#define SOLVER_H
/* Uncomment the next line to remove all library dependencies. */
/*#define ZERO_LIBRARY_MODE */
#ifdef MATLAB_MEX_FILE
/* Matlab functions. MATLAB_MEX_FILE will be defined by the mex compiler. */
/* If you are not using the mex compiler, this functionality will not intrude, */
/* as it will be completely disabled at compile-time. */
#include "mex.h"
#else
#ifndef ZERO_LIBRARY_MODE
#include <stdio.h>
#endif
#endif
/* Space must be allocated somewhere (testsolver.c, csolve.c or your own */
/* program) for the global variables vars, params, work and settings. */
/* At the bottom of this file, they are externed. */
#ifndef ZERO_LIBRARY_MODE
#include <math.h>
#define pm(A, m, n) printmatrix(#A, A, m, n, 1)
#endif
typedef struct Params_t {
  double x_0[6];
  double x_des_0[6];
  double Wy[6];
  double r_des_0[2];
  double Wr[2];
  double x_des_1[6];
  double r_des_1[2];
  double x_des_2[6];
  double r_des_2[2];
  double x_des_3[6];
  double r_des_3[2];
  double x_des_4[6];
  double r_des_4[2];
  double x_des_5[6];
  double r_des_5[2];
  double x_des_6[6];
  double r_des_6[2];
  double x_des_7[6];
  double r_des_7[2];
  double x_des_8[6];
  double r_des_8[2];
  double x_des_9[6];
  double r_des_9[2];
  double x_des_10[6];
  double r_des_10[2];
  double x_des_11[6];
  double Wy_final[6];
  double A[36];
  double B[12];
  double r_min[2];
  double r_max[2];
  double *x[1];
  double *x_des[12];
  double *r_des[11];
} Params;
typedef struct Vars_t {
  double *r_0; /* 2 rows. */
  double *x_1; /* 6 rows. */
  double *r_1; /* 2 rows. */
  double *x_2; /* 6 rows. */
  double *r_2; /* 2 rows. */
  double *x_3; /* 6 rows. */
  double *r_3; /* 2 rows. */
  double *x_4; /* 6 rows. */
  double *r_4; /* 2 rows. */
  double *x_5; /* 6 rows. */
  double *r_5; /* 2 rows. */
  double *x_6; /* 6 rows. */
  double *r_6; /* 2 rows. */
  double *x_7; /* 6 rows. */
  double *r_7; /* 2 rows. */
  double *x_8; /* 6 rows. */
  double *r_8; /* 2 rows. */
  double *x_9; /* 6 rows. */
  double *r_9; /* 2 rows. */
  double *x_10; /* 6 rows. */
  double *r_10; /* 2 rows. */
  double *x_11; /* 6 rows. */
  double *r[11];
  double *x[12];
} Vars;
typedef struct Workspace_t {
  double h[44];
  double s_inv[44];
  double s_inv_z[44];
  double b[66];
  double q[88];
  double rhs[242];
  double x[242];
  double *s;
  double *z;
  double *y;
  double lhs_aff[242];
  double lhs_cc[242];
  double buffer[242];
  double buffer2[242];
  double KKT[822];
  double L[1148];
  double d[242];
  double v[242];
  double d_inv[242];
  double gap;
  double optval;
  double ineq_resid_squared;
  double eq_resid_squared;
  double block_33[1];
  /* Pre-op symbols. */
  double quad_851572719616[1];
  double quad_528984948736[1];
  double quad_769265315840[1];
  double quad_847677124608[1];
  double quad_771568988160[1];
  double quad_146025250816[1];
  double quad_939734863872[1];
  double quad_234961223680[1];
  double quad_734055882752[1];
  double quad_400962260992[1];
  double quad_955949862912[1];
  double quad_867114881024[1];
  double quad_103084154880[1];
  double quad_176443363328[1];
  double quad_411422265344[1];
  double quad_710678761472[1];
  double quad_631712628736[1];
  double quad_765946638336[1];
  double quad_97738092544[1];
  double quad_399495258112[1];
  double quad_755044708352[1];
  double quad_311848521728[1];
  double quad_54433812480[1];
  int converged;
} Workspace;
typedef struct Settings_t {
  double resid_tol;
  double eps;
  int max_iters;
  int refine_steps;
  int better_start;
  /* Better start obviates the need for s_init and z_init. */
  double s_init;
  double z_init;
  int verbose;
  /* Show extra details of the iterative refinement steps. */
  int verbose_refinement;
  int debug;
  /* For regularization. Minimum value of abs(D_ii) in the kkt D factor. */
  double kkt_reg;
} Settings;
extern Vars vars;
extern Params params;
extern Workspace work;
extern Settings settings;
/* Function definitions in ldl.c: */
void ldl_solve(double *target, double *var);
void ldl_factor(void);
double check_factorization(void);
void matrix_multiply(double *result, double *source);
double check_residual(double *target, double *multiplicand);
void fill_KKT(void);

/* Function definitions in matrix_support.c: */
void multbymA(double *lhs, double *rhs);
void multbymAT(double *lhs, double *rhs);
void multbymG(double *lhs, double *rhs);
void multbymGT(double *lhs, double *rhs);
void multbyP(double *lhs, double *rhs);
void fillq(void);
void fillh(void);
void fillb(void);
void pre_ops(void);

/* Function definitions in solver.c: */
double eval_gap(void);
void set_defaults(void);
void setup_pointers(void);
void setup_indexed_params(void);
void setup_indexed_optvars(void);
void setup_indexing(void);
void set_start(void);
double eval_objv(void);
void fillrhs_aff(void);
void fillrhs_cc(void);
void refine(double *target, double *var);
double calc_ineq_resid_squared(void);
double calc_eq_resid_squared(void);
void better_start(void);
void fillrhs_start(void);
long solve(void);

/* Function definitions in testsolver.c: */
int main(int argc, char **argv);
void load_default_data(void);

/* Function definitions in util.c: */
void tic(void);
float toc(void);
float tocq(void);
void printmatrix(char *name, double *A, int m, int n, int sparse);
double unif(double lower, double upper);
float ran1(long*idum, int reset);
float randn_internal(long *idum, int reset);
double randn(void);
void reset_rand(void);

#endif
