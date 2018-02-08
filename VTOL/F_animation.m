function F_animation(u)

    F_param
    % process inputs to function
    zv       = u(1);
    h        = u(2);
    theta    = u(3);
    zt       = u(4);
    t        = u(5);
    
    % drawing parameters
    d = P.d;
    
    % define persistent variables 
    persistent copter_handle
    persistent target_handle
    
    % first time function is called, initialize plot and persistent vars
    if t==0,
        figure(1), clf
        plot([P.l_lim, P.u_lim],[0,0],'k:'); % plot track
        hold on
        axis([P.l_lim, P.u_lim, P.l_lim, P.u_lim]);
        axis('square')
        title('VTOL')
        xlabel('Z \it[m]')
        
        copter_handle = drawCopter(zv, h, theta, d, P.a, P.b, P.bl, []);
        target_handle = drawTarget(zt, P.bl, []);
         
    % at every other time step, redraw ball and beam
    else 
        drawCopter(zv, h, theta, d, P.a, P.b, P.bl, copter_handle);
        drawTarget(zt, P.bl, target_handle);
    end
end

   
%
%=======================================================================
% drawBall
% draw the ball
% return handle if 3rd argument is empty, otherwise use 3rd arg as handle
%=======================================================================
%
function handle = drawBody(zv, h, theta, bl, handle)
  pt = [-bl/2 bl/2;0 0];
  XY = [cos(theta) -sin(theta);sin(theta) cos(theta)]*pt;
  X = XY(1,:)+zv; Y = XY(2,:)+h;

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
function handle = drawCopter(zv, h, theta, d, a, b, bl, handle)
  
  X1 = -d;
  X2 = d;
  Y = 0;
  XY1 = [X1 Y]*[cos(theta) sin(theta);-sin(theta) cos(theta)];
  XY2 = [X2 Y]*[cos(theta) sin(theta);-sin(theta) cos(theta)];
  X1 = XY1(1)+zv; X2 = XY2(1)+zv;
  Y1 = XY1(2)+h; Y2 = XY2(2)+h;
  
  pt = [-bl/2 bl/2;0 0];
  XY = [cos(theta) -sin(theta);sin(theta) cos(theta)]*pt;
  X = XY(1,:)+zv; Y = XY(2,:)+h;
  
  if isempty(handle),
    handle(1) = drawEllipse(a, b, X1, Y1, theta, 'g');
    handle(2) = drawEllipse(a, b, X2, Y2, theta, 'g');
    handle(3) = plot([X1 X2], [Y1 Y2], 'g','LineWidth',1);
    handle(4) = drawBody(zv, h, theta, bl, []);
  else
    t=-pi:0.01:pi;
    x=a*cos(t);
    y=b*sin(t);
    R = [cos(theta) -sin(theta);sin(theta) cos(theta)];
    XY = R*[x;y];
    X1 = XY(1,:)+X1; X2 = XY(1,:)+X2;
    Y1 = XY(2,:)+Y1; Y2 = XY(2,:)+Y2;
    set(handle(1),'XData',X1,'YData',Y1);
    set(handle(2),'XData',X2,'YData',Y2);
    set(handle(3),'XData',[X1 X2],'YData',[Y1 Y2]);
    set(handle(4),'XData',X,'YData',Y);
    drawnow
  end
end

function handle = drawTarget(zt, bl, handle)
  X = [zt-bl/3 zt+bl/3];
  Y = [0, 0];

  if isempty(handle),
    handle = plot(X, Y, 'k','LineWidth',9);
  else
    set(handle,'XData',X,'YData',Y);
    drawnow
  end
end