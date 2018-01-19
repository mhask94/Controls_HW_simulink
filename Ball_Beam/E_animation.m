function E_animation(u)

    E_param
    % process inputs to function
    z        = u(1);
    theta    = u(2);
    zdot     = u(3);
    thetadot = u(4);
    t        = u(5);
    
    % drawing parameters
    L = P.ell;
    gap = P.gap;
    
    % define persistent variables 
    persistent ball_handle
    persistent beam_handle
    
    % first time function is called, initialize plot and persistent vars
    if t==0,
        figure(1), clf
        plot([0, L],[0,0],'k:'); % plot track
        hold on
        beam_handle  = drawBeam(theta, L, []);
        ball_handle = drawBall(z, theta, gap, []);
        axis([P.l_lim, P.u_lim, P.l_lim, P.u_lim]);
        title('Ball and Beam')
        xlabel('Z \it[m]')
    
        
    % at every other time step, redraw ball and beam
    else 
        drawBeam(theta, L, beam_handle);
        drawBall(z, theta, gap, ball_handle);
    end
end

   
%
%=======================================================================
% drawBall
% draw the ball
% return handle if 3rd argument is empty, otherwise use 3rd arg as handle
%=======================================================================
%
function handle = drawBall(z, theta, gap, handle)
  
  pt = [z;gap];
  XY = [cos(theta) -sin(theta);sin(theta) cos(theta)]*pt;
  X = XY(1); Y = XY(2);
%   X = pt(1); Y = pt(2);
  if isempty(handle),
    handle = plot(X,Y,'b.','MarkerSize',50);
  else
    set(handle,'XData',X,'YData',Y);
    drawnow
  end
end
 
%
%=======================================================================
% drawBeam
% draw the beam
% return handle if 3rd argument is empty, otherwise use 3rd arg as handle
%=======================================================================
%
function handle = drawBeam(theta, L, handle)

  
  X = [0, L];
  Y = [0, 0];
  XY1 = [X' Y']*[cos(theta) sin(theta);-sin(theta) cos(theta)];
  X = XY1(:,1); Y = XY1(:,2);

  if isempty(handle),
    handle = plot(X, Y, 'k','LineWidth',9);
  else
    set(handle,'XData',X,'YData',Y);
    drawnow
  end
end

  
