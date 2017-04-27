function Standard_Deviation = calculateStandardDeviations_function(surface, length_of_surface)
sum_surface=sum(surface(1,:),2);
average_surface_line=sum_surface./length_of_surface
average_surface_line_picture(1,1:length_of_surface)=average_surface_line

stdSurface = std(surface,0,2);
Standard_Deviation = stdSurface(1);

% Standard_Deviation_matrix(1,1)=Standard_Deviation;



end
