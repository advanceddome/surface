surface
sum_surface=sum(surface(1,:),2)
z=sum_surface./length_of_surface
picture_z(1,1:length_of_surface)=z
plot(picture_z,'k')
