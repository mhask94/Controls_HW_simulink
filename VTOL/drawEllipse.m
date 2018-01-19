function ellipse = drawEllipse(a,b,x0,y0,theta,color)
    t=-pi:0.01:pi;
    x=a*cos(t);
    y=b*sin(t);
    R = [cos(theta) -sin(theta);sin(theta) cos(theta)];
    XY = R*[x;y];
    x = XY(1,:)+x0; y = XY(2,:)+y0;
    ellipse = fill(x,y,color)
end
