/* Produced by CVXGEN, 2018-11-01 18:58:24 -0400.  */
/* CVXGEN is Copyright (C) 2006-2017 Jacob Mattingley, jem@cvxgen.com. */
/* The code in this file is Copyright (C) 2006-2017 Jacob Mattingley. */
/* CVXGEN, or solvers produced by CVXGEN, cannot be used for commercial */
/* applications without prior written permission from Jacob Mattingley. */

/* Filename: testsolver.c. */
/* Description: Basic test harness for solver.c. */
#include "solver.h"
Vars vars;
Params params;
Workspace work;
Settings settings;
#define NUMTESTS 0
int main(int argc, char **argv) {
  int num_iters;
#if (NUMTESTS > 0)
  int i;
  double time;
  double time_per;
#endif
  set_defaults();
  setup_indexing();
  load_default_data();
  /* Solve problem instance for the record. */
  settings.verbose = 1;
  num_iters = solve();
#ifndef ZERO_LIBRARY_MODE
#if (NUMTESTS > 0)
  /* Now solve multiple problem instances for timing purposes. */
  settings.verbose = 0;
  tic();
  for (i = 0; i < NUMTESTS; i++) {
    solve();
  }
  time = tocq();
  printf("Timed %d solves over %.3f seconds.\n", NUMTESTS, time);
  time_per = time / NUMTESTS;
  if (time_per > 1) {
    printf("Actual time taken per solve: %.3g s.\n", time_per);
  } else if (time_per > 1e-3) {
    printf("Actual time taken per solve: %.3g ms.\n", 1e3*time_per);
  } else {
    printf("Actual time taken per solve: %.3g us.\n", 1e6*time_per);
  }
#endif
#endif
  return 0;
}
void load_default_data(void) {
  params.x_0[0] = 0.20319161029830202;
  params.x_0[1] = 0.8325912904724193;
  params.x_0[2] = -0.8363810443482227;
  params.x_0[3] = 0.04331042079065206;
  params.x_0[4] = 1.5717878173906188;
  params.x_0[5] = 1.5851723557337523;
  params.x_des_0[0] = -1.497658758144655;
  params.x_des_0[1] = -1.171028487447253;
  params.x_des_0[2] = -1.7941311867966805;
  params.x_des_0[3] = -0.23676062539745413;
  params.x_des_0[4] = -1.8804951564857322;
  params.x_des_0[5] = -0.17266710242115568;
  params.Wy[0] = 1.6491440476147607;
  params.Wy[1] = 1.2784872826479754;
  params.Wy[2] = 1.6762549019801312;
  params.Wy[3] = 1.5908628174163508;
  params.Wy[4] = 1.0239818823771654;
  params.Wy[5] = 1.5588540879908819;
  params.r_des_0[0] = -0.9629902123701384;
  params.r_des_0[1] = -0.3395952119597214;
  params.Wr[0] = 1.2835250817713186;
  params.Wr[1] = 1.6931379183129964;
  params.x_des_1[0] = -0.23818512931704205;
  params.x_des_1[1] = -1.372529046100147;
  params.x_des_1[2] = 0.17859607212737894;
  params.x_des_1[3] = 1.1212590580454682;
  params.x_des_1[4] = -0.774545870495281;
  params.x_des_1[5] = -1.1121684642712744;
  params.r_des_1[0] = -0.44811496977740495;
  params.r_des_1[1] = 1.7455345994417217;
  params.x_des_2[0] = 1.9039816898917352;
  params.x_des_2[1] = 0.6895347036512547;
  params.x_des_2[2] = 1.6113364341535923;
  params.x_des_2[3] = 1.383003485172717;
  params.x_des_2[4] = -0.48802383468444344;
  params.x_des_2[5] = -1.631131964513103;
  params.r_des_2[0] = 0.6136436100941447;
  params.r_des_2[1] = 0.2313630495538037;
  params.x_des_3[0] = -0.5537409477496875;
  params.x_des_3[1] = -1.0997819806406723;
  params.x_des_3[2] = -0.3739203344950055;
  params.x_des_3[3] = -0.12423900520332376;
  params.x_des_3[4] = -0.923057686995755;
  params.x_des_3[5] = -0.8328289030982696;
  params.r_des_3[0] = -0.16925440270808823;
  params.r_des_3[1] = 1.442135651787706;
  params.x_des_4[0] = 0.34501161787128565;
  params.x_des_4[1] = -0.8660485502711608;
  params.x_des_4[2] = -0.8880899735055947;
  params.x_des_4[3] = -0.1815116979122129;
  params.x_des_4[4] = -1.17835862158005;
  params.x_des_4[5] = -1.1944851558277074;
  params.r_des_4[0] = 0.05614023926976763;
  params.r_des_4[1] = -1.6510825248767813;
  params.x_des_5[0] = -0.06565787059365391;
  params.x_des_5[1] = -0.5512951504486665;
  params.x_des_5[2] = 0.8307464872626844;
  params.x_des_5[3] = 0.9869848924080182;
  params.x_des_5[4] = 0.7643716874230573;
  params.x_des_5[5] = 0.7567216550196565;
  params.r_des_5[0] = -0.5055995034042868;
  params.r_des_5[1] = 0.6725392189410702;
  params.x_des_6[0] = -0.6406053441727284;
  params.x_des_6[1] = 0.29117547947550015;
  params.x_des_6[2] = -0.6967713677405021;
  params.x_des_6[3] = -0.21941980294587182;
  params.x_des_6[4] = -1.753884276680243;
  params.x_des_6[5] = -1.0292983112626475;
  params.r_des_6[0] = 1.8864104246942706;
  params.r_des_6[1] = -1.077663182579704;
  params.x_des_7[0] = 0.7659100437893209;
  params.x_des_7[1] = 0.6019074328549583;
  params.x_des_7[2] = 0.8957565577499285;
  params.x_des_7[3] = -0.09964555746227477;
  params.x_des_7[4] = 0.38665509840745127;
  params.x_des_7[5] = -1.7321223042686946;
  params.r_des_7[0] = -1.7097514487110663;
  params.r_des_7[1] = -1.2040958948116867;
  params.x_des_8[0] = -1.3925560119658358;
  params.x_des_8[1] = -1.5995826216742213;
  params.x_des_8[2] = -1.4828245415645833;
  params.x_des_8[3] = 0.21311092723061398;
  params.x_des_8[4] = -1.248740700304487;
  params.x_des_8[5] = 1.808404972124833;
  params.r_des_8[0] = 0.7264471152297065;
  params.r_des_8[1] = 0.16407869343908477;
  params.x_des_9[0] = 0.8287224032315907;
  params.x_des_9[1] = -0.9444533161899464;
  params.x_des_9[2] = 1.7069027370149112;
  params.x_des_9[3] = 1.3567722311998827;
  params.x_des_9[4] = 0.9052779937121489;
  params.x_des_9[5] = -0.07904017565835986;
  params.r_des_9[0] = 1.3684127435065871;
  params.r_des_9[1] = 0.979009293697437;
  params.x_des_10[0] = 0.6413036255984501;
  params.x_des_10[1] = 1.6559010680237511;
  params.x_des_10[2] = 0.5346622551502991;
  params.x_des_10[3] = -0.5362376605895625;
  params.x_des_10[4] = 0.2113782926017822;
  params.x_des_10[5] = -1.2144776931994525;
  params.r_des_10[0] = -1.2317108144255875;
  params.r_des_10[1] = 0.9026784957312834;
  params.x_des_11[0] = 1.1397468137245244;
  params.x_des_11[1] = 1.8883934547350631;
  params.x_des_11[2] = 1.4038856681660068;
  params.x_des_11[3] = 0.17437730638329096;
  params.x_des_11[4] = -1.6408365219077408;
  params.x_des_11[5] = -0.04450702153554875;
  params.Wy_final[0] = 1.9279363475621256;
  params.Wy_final[1] = 1.7876181995034763;
  params.Wy_final[2] = 1.485094226054088;
  params.Wy_final[3] = 1.4552793614808863;
  params.Wy_final[4] = 1.2179857684093536;
  params.Wy_final[5] = 1.1772133808018235;
  params.A[0] = -1.7055053231225696;
  params.A[1] = 1.56957275034837;
  params.A[2] = 0.5607064675962357;
  params.A[3] = -1.4266707301147146;
  params.A[4] = -0.3434923211351708;
  params.A[5] = -1.8035643024085055;
  params.A[6] = -1.1625066019105454;
  params.A[7] = 0.9228324965161532;
  params.A[8] = 0.6044910817663975;
  params.A[9] = -0.0840868104920891;
  params.A[10] = -0.900877978017443;
  params.A[11] = 0.608892500264739;
  params.A[12] = 1.8257980452695217;
  params.A[13] = -0.25791777529922877;
  params.A[14] = -1.7194699796493191;
  params.A[15] = -1.7690740487081298;
  params.A[16] = -1.6685159248097703;
  params.A[17] = 1.8388287490128845;
  params.A[18] = 0.16304334474597537;
  params.A[19] = 1.3498497306788897;
  params.A[20] = -1.3198658230514613;
  params.A[21] = -0.9586197090843394;
  params.A[22] = 0.7679100474913709;
  params.A[23] = 1.5822813125679343;
  params.A[24] = -0.6372460621593619;
  params.A[25] = -1.741307208038867;
  params.A[26] = 1.456478677642575;
  params.A[27] = -0.8365102166820959;
  params.A[28] = 0.9643296255982503;
  params.A[29] = -1.367865381194024;
  params.A[30] = 0.7798537405635035;
  params.A[31] = 1.3656784761245926;
  params.A[32] = 0.9086083149868371;
  params.A[33] = -0.5635699005460344;
  params.A[34] = 0.9067590059607915;
  params.A[35] = -1.4421315032701587;
  params.B[0] = -0.7447235390671119;
  params.B[1] = -0.32166897326822186;
  params.B[2] = 1.5088481557772684;
  params.B[3] = -1.385039165715428;
  params.B[4] = 1.5204991609972622;
  params.B[5] = 1.1958572768832156;
  params.B[6] = 1.8864971883119228;
  params.B[7] = -0.5291880667861584;
  params.B[8] = -1.1802409243688836;
  params.B[9] = -1.037718718661604;
  params.B[10] = 1.3114512056856835;
  params.B[11] = 1.8609125943756615;
  params.r_min[0] = 0.7952399935216938;
  params.r_min[1] = -0.07001183290468038;
  params.r_max[0] = 0.5740995293622657;
  params.r_max[1] = 1.6673757686863193;
}
