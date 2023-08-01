hold on;
plot(-Xpos(step,2:8),Zpos(step,2:8),'.b','markersize',10);
for i = 1:8
    x1 = -Xpos(step,i);
    x2 = -Xpos(step,i+1);
    y1 = Zpos(step,i);
    y2 = Zpos(step,i+1);
    e = 0.98;
    a = 1/2*sqrt((x2-x1)^2+(y2-y1)^2);
    b = a*sqrt(1-e^2);
    t_ = linspace(0,2*pi);
    X = a*cos(t_);
    Y = b*sin(t_);
    w = atan2(y2-y1,x2-x1);
    x = (x1+x2)/2 + X*cos(w) - Y*sin(w);
    y = (y1+y2)/2 + X*sin(w) + Y*cos(w);
    plot(x,y,'k-');
end
hold off;