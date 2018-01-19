function F_animation(u)

    F_param
    % process inputs to function
    zv       = u(1);
    zt       = u(2);
    h        = u(3);
    theta    = u(4);
    t        = u(5);
    
    % drawing parameters
    d = P.d;
    gap = P.gap;
    height = P.h;
    radius = P.radius;
    
    % define persistent variables 
    persistent body_handle
    persistent Lprop_handle
    persistent Rprop_handle
    persistent line_handle
    persistent target_handle
    
    % first time function is called, initialize plot and persistent vars
    if t==0,
        figure(1), clf
        plot([0, L],[0,0],'k:'); % plot track
        hold on
        body_handle  = drawBody(zv, h, theta, []);
        Lprop_handle = drawLprop(zv, h, theta, d, []);
        Rprop_handle = drawRprop(zv, h, theta, d, []);
        line_handle = drawLine(zv, h, theta, d, []);
        target_handle = drawTarget(zt, []);
        axis([P.l_lim, P.u_lim, P.l_lim, P.u_lim]);
        title('VTOL')
        xlabel('Z \it[m]')
    
        
    % at every other time step, redraw ball and beam
    else 
        drawBeam(zt, L, beam_handle);
        drawBall(zv, zt, radius, gap, ball_handle);
    end
end

   
%
%=======================================================================
% drawBall
% draw the ball
% return handle if 3rd argument is empty, otherwise use 3rd arg as handle
%=======================================================================
%
function handle = drawBody(zv, h, theta, handle)
  
  pt = [zv;h];
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
function handle = drawLprop(zv, h, theta, d, handle)

  
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

function handle = drawRprop(zv, h, theta, d, handle)

  
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

function handle = drawLine(zv, h, theta, d, handle)

  
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

function handle = drawTarget(zt, h, theta, d, handle)

  
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