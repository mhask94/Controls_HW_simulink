function [sys,x0,str,ts,simStateCompliance] = F_dynamics(t,x,u,flag,P)
switch flag,

  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0,
    [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes(P);

  %%%%%%%%%%%%%%%
  % Derivatives %
  %%%%%%%%%%%%%%%
  case 1,
    sys=mdlDerivatives(t,x,u,P);

  %%%%%%%%%%
  % Update %
  %%%%%%%%%%
  case 2,
    sys=mdlUpdate(t,x,u);

  %%%%%%%%%%%
  % Outputs %
  %%%%%%%%%%%
  case 3,
    sys=mdlOutputs(t,x,u);

  %%%%%%%%%%%%%%%%%%%%%%%
  % GetTimeOfNextVarHit %
  %%%%%%%%%%%%%%%%%%%%%%%
  case 4,
    sys=mdlGetTimeOfNextVarHit(t,x,u);

  %%%%%%%%%%%%%
  % Terminate %
  %%%%%%%%%%%%%
  case 9,
    sys=mdlTerminate(t,x,u);

  %%%%%%%%%%%%%%%%%%%%
  % Unexpected flags %
  %%%%%%%%%%%%%%%%%%%%
  otherwise
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));

end

% end sfuntmpl

%
%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%
function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes(P)

%
% call simsizes for a sizes structure, fill it in and convert it to a
% sizes array.
%
% Note that in this example, the values are hard coded.  This is not a
% recommended practice as the characteristics of the block are typically
% defined by the S-function parameters.
%
sizes = simsizes;

sizes.NumContStates  = 6;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 9;
sizes.NumInputs      = 2;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);

%
% initialize the initial conditions
%
x0  = [P.zv0; P.h0; P.theta0; P.zvd0; P.hd0; P.thetad0];
% x0  = [P.zv0; P.theta0; P.zvd0; P.thetad0];

%
% str is always an empty matrix
%
str = [];

%
% initialize the array of sample times
%
ts  = [0 0];

% Specify the block simStateCompliance. The allowed values are:
%    'UnknownSimState', < The default setting; warn and assume DefaultSimState
%    'DefaultSimState', < Same sim state as a built-in block
%    'HasNoSimState',   < No sim state
%    'DisallowSimState' < Error out when saving or restoring the model sim state
simStateCompliance = 'UnknownSimState';

% end mdlInitializeSizes

%
%=============================================================================
% mdlDerivatives
% Return the derivatives for the continuous states.
%=============================================================================
%
function sys=mdlDerivatives(t,x,u,P)
  zv       = x(1);
  h        = x(2);
  theta    = x(3);
  zvd      = x(4);
  hd       = x(5);
  thetad   = x(6);
%   F        = u(1);
%   Tau      = u(2);
  Fr         = u(1);
  Fl         = u(2);
  
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % The parameters for any physical system are never known exactly.  Feedback
  % systems need to be designed to be robust to this uncertainty.  In the simulation
  % we model uncertainty by changing the physical parameters by a uniform random variable
  % that represents alpha*100 % of the parameter, i.e., alpha = 0.2, means that the parameter
  % may change by up to 20%.  A different parameter value is chosen every time the simulation
  % is run.
  persistent mr
%   persistent ml
  persistent mc
  persistent Jc
  persistent mu
  persistent g
  persistent d
  if t==0
    alpha = 0.0;  % uncertainty parameter
    mr = P.mr * (1+2*alpha*rand-alpha);  % kg
%     ml = P.ml * (1+2*alpha*rand-alpha);     % kg
    mc = P.mc * (1+2*alpha*rand-alpha);  % kg
    Jc = P.Jc * (1+2*alpha*rand-alpha); % 
    mu = P.mu * (1+2*alpha*rand-alpha); % 
    g = P.g; % the gravity vector is well known and so we don't change it.
    d = P.d;
  end
  
  F = Fl+Fr;
  Tau = d*(Fr-Fl);
  F_wind = 0.0;
  
  % define system dynamics xdot=f(x,u)  
  zvdd = -(mu*zvd+F*sin(theta)+F_wind)/(mc+2*mr);
%   zvdd = 0;
  hdd = F*cos(theta)/(mc+2*mr)-g;
  thetadd = Tau/(Jc+2*mr*d^2);
%   thetadd = 0;

sys = [zvd; hd; thetad; zvdd; hdd; thetadd];
% sys = [zvd; thetad; zvdd; thetadd];

% end mdlDerivatives

%
%=============================================================================
% mdlUpdate
% Handle discrete state updates, sample time hits, and major time step
% requirements.
%=============================================================================
%
function sys=mdlUpdate(t,x,u)

sys = [];

% end mdlUpdate

%
%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
%
function sys=mdlOutputs(t,x,u)
    zv_m       = x(1);
    h_m        = x(2);
    theta_m    = x(3);
    x_lon = [h_m;x(5)];
    x_lat = [zv_m;theta_m;x(4);x(6)];
%     theta    = x(2);
    % add Gaussian noise to the outputs
%     z_m = z;% + 0.01*randn;
%     theta_m = theta;% + 0.001*randn;
sys = [zv_m; h_m; theta_m; x_lon; x_lat];
% sys = [zv; theta];%; x];

% end mdlOutputs

%
%=============================================================================
% mdlGetTimeOfNextVarHit
% Return the time of the next hit for this block.  Note that the result is
% absolute time.  Note that this function is only used when you specify a
% variable discrete-time sample time [-2 0] in the sample time array in
% mdlInitializeSizes.
%=============================================================================
%
function sys=mdlGetTimeOfNextVarHit(t,x,u)

sampleTime = 1;    %  Example, set the next hit to be one second later.
sys = t + sampleTime;

% end mdlGetTimeOfNextVarHit

%
%=============================================================================
% mdlTerminate
% Perform any end of simulation tasks.
%=============================================================================
%
function sys=mdlTerminate(t,x,u)

sys = [];

% end mdlTerminate
