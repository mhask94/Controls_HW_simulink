function ellipse = drawEllipse(a,b,x0,y0,theta)
%     a=1; % horizontal radius
%     b=.5; % vertical radius
%     x0=2; % x0,y0 ellipse centre coordinates
%     y0=3;
%     theta = 30 * pi/180;
    t=-pi:0.01:pi;
    x=a*cos(t);
    y=b*sin(t);
    R = [cos(theta) -sin(theta);sin(theta) cos(theta)];
    XY = R*[x;y];
    x = XY(1,:)+x0; y = XY(2,:)+y0;
    ellipse = plot(x,y)
end
