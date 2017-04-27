xx = 0:length_of_surface;
yy = spline(surface(1,:),length_of_surface,xx);
plot(x,y,'o',xx,yy)
