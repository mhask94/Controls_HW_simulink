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
%     gap = P.gap;
%     height = P.h;
    
    % define persistent variables 
    persistent body_handle
    persistent Lprop_handle
    persistent Rprop_handle
    persistent line_handle
    persistent target_handle
    
    % first time function is called, initialize plot and persistent vars
    if t==0,
        figure(1), clf
        plot([P.l_lim, P.u_lim],[0,0],'k:'); % plot track
        hold on
        axis([P.l_lim, P.u_lim, P.l_lim, P.u_lim]);
        title('VTOL')
        xlabel('Z \it[m]')
        
        body_handle  = drawBody(zv, h, theta, []);
        Lprop_handle = drawLprop(zv, h, theta, d, []);
        Rprop_handle = drawRprop(zv, h, theta, d, []);
        line_handle = drawLine(zv, h, theta, d, []);
        target_handle = drawTarget(zt, []);
         
    % at every other time step, redraw ball and beam
    else 
        drawBody(zv, h, theta, body_handle);
        drawLprop(zv, h, theta, d, Lprop_handle);
        drawRprop(zv, h, theta, d, Rprop_handle);
        drawLine(zv, h, theta, d, line_handle);
        drawTarget(zt, target_handle);
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
  F_param
  pt = [zv-P.bl/2 zv+P.bl/2;h h];
  XY = [cos(theta) -sin(theta);sin(theta) cos(theta)]*pt;
  X = XY(1,:); Y = XY(2,:);
%   X = pt(1); Y = pt(2);
  if isempty(handle),
    handle = plot(X,Y,'g','LineWidth',10);
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
  F_param
  X = -d;
  Y = 0;
  XY1 = [X Y]*[cos(theta) sin(theta);-sin(theta) cos(theta)];
  X = XY1(1)+zv; Y = XY1(2)+h;
  
  if isempty(handle),
    handle = drawEllipse(P.a, P.b, X, Y, theta, 'g');
  else
    set(handle,'XData',X,'YData',Y);
    drawnow
  end
end

function handle = drawRprop(zv, h, theta, d, handle)
  F_param
  X = d;
  Y = 0;
  XY1 = [X Y]*[cos(theta) sin(theta);-sin(theta) cos(theta)];
  X = XY1(1)+zv; Y = XY1(2)+h;
  
  if isempty(handle),
    handle = drawEllipse(P.a, P.b, X, Y, theta, 'g');
  else
    set(handle,'XData',X,'YData',Y);
    drawnow
  end
end

function handle = drawLine(zv, h, theta, d, handle)
  
  X = -d;
  Y = 0;
  XY1 = [X Y]*[cos(theta) sin(theta);-sin(theta) cos(theta)];
  X1 = XY1(1)+zv; Y1 = XY1(2)+h;
  
  X = d;
  XY1 = [X Y]*[cos(theta) sin(theta);-sin(theta) cos(theta)];
  X2 = XY1(1)+zv; Y2 = XY1(2)+h;
  
  X = [X1 X2]; Y = [Y1 Y2];

  if isempty(handle),
    handle = plot(X, Y, 'g','LineWidth',1);
  else
    set(handle,'XData',X,'YData',Y);
    drawnow
  end
end

function handle = drawTarget(zt, handle)
  F_param
  X = [zt-P.bl/3 zt+P.bl/3];
  Y = [0, 0];

  if isempty(handle),
    handle = plot(X, Y, 'k','LineWidth',9);
  else
    set(handle,'XData',X,'YData',Y);
    drawnow
  end
end