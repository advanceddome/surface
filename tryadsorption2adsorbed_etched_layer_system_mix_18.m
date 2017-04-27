clear
close all

length_of_surface=100  %surfacewidth
[X,Y] = meshgrid(0:length_of_surface, 0:20);

probability=zeros(size(X))
initialmatrix = ones(size(X)); %colors has ones everywhere besides row 1,2==0
adsorption=zeros(size(X));
desorption=zeros(size(X));
initialmatrix(1:2, :) = 0;
etchcycles=15
Standard_Deviation_matrix=zeros(etchcycles,1);


a=1         %parameters a and b for the probability of adsorbens number 1 and 2
b=100
 

% find starting row of 1's for each column (creates surface matrix)

for i=1:length_of_surface
    surface(i)=find(initialmatrix(:,i),1)
end
surface(2,:)=0;


% sin_curve characteristics
amplitude = 2
periodicity = 10;
position_sin_curve = 7

% surface shape of sine
for i=1:length_of_surface
surface(1,i) = round((amplitude.*sin(i.*2.*pi/periodicity)))+position_sin_curve;
end

 
%  plot (surface(1,1:length_of_surface),'k')


  pictureTest=ones(size(X))   

%  creates 2D matrix and picture out of surface matrix
 for k=2:length_of_surface
    if surface(1,k)~=0
         pictureTest(surface(1,k),k)=1; 
         
         pictureTest(1:surface(1,k)-1,k)=0;
    end
 end
 
%   cuts the beginning and end of
 pictureTest(:,1:2)=0                 
 pictureTest(:,length_of_surface:length_of_surface+1)=0
 figure;
 spy(pictureTest,'r')

 
 
 
% starting probability for first etch cycle
probability(1,:)=50;


%probabilities for etching
probablityAdsorption1 = 85;
probablityAdsorption2 = 60;
probablityAdsorption3 = 50;
probabilityAdsorption_Spline=0

% adds Standard Deviation in the beginning
Standard_Deviation_matrix(1,1)=calculateStandardDeviations_function(surface, length_of_surface);


% setting the etching circles
for number_of_etching=1:etchcycles

% probability of colors2=green dots to place on red (surface)
for surfaceposition=2:length_of_surface
   Z=a+(b-a).*rand(1,1);
             if Z>probability(1,surfaceposition)
                adsorption(surface(1,surfaceposition)-1,surfaceposition)=1
             else 
                adsorption(surface(1,surfaceposition),surfaceposition)=0
             end


% probability of colors3 =blue dots to place on the row above


      Z=a+(b-a).*rand(1,1);
             if Z>probability(1,surfaceposition)
                desorption(surface(1,surfaceposition)-2,surfaceposition)=1
             else 
                desorption(surface(1,surfaceposition),surfaceposition)=0
             end

% removes surface atom, when green and blue are above
% for column = 1:length(colors(1,:)+1)
    if adsorption(surface(1,surfaceposition)-1,surfaceposition) && desorption(surface(1,surfaceposition)-2,surfaceposition)==1
         surface(1,surfaceposition)= surface(1,surfaceposition)+1  
     end

end

% calculates the probability for each surface atom after each etch step
if number_of_etching>1
 for surfaceposition=2:length_of_surface-1
     
     if surface(1,surfaceposition)== surface(1,surfaceposition+1)
        if surface(1,surfaceposition)== surface(1,surfaceposition-1)
            surface(2,surfaceposition)=1
            surface(3,surfaceposition)=probablityAdsorption1;
        end
        if surface(1,surfaceposition)< surface(1,surfaceposition-1)
            surface(2,surfaceposition)=2
            surface(3,surfaceposition)=probablityAdsorption1; 
        end
        if surface(1,surfaceposition)> surface(1,surfaceposition-1)
            surface(2,surfaceposition)=1
            surface(3,surfaceposition)=probablityAdsorption1;
        end
     end
     if surface(1,surfaceposition)> surface(1,surfaceposition+1)
         if surface(1,surfaceposition)== surface(1,surfaceposition-1)
              surface(2,surfaceposition)=1
              surface(3,surfaceposition)=probablityAdsorption1;
         end
         if surface(1,surfaceposition)> surface(1,surfaceposition-1)
              surface(2,surfaceposition)=1
              surface(3,surfaceposition)=probablityAdsorption1;
         end
         if surface(1,surfaceposition)< surface(1,surfaceposition-1)
              surface(2,surfaceposition)=2
              surface(3,surfaceposition)=probablityAdsorption2;
         end
     end       
      if surface(1,surfaceposition)< surface(1,surfaceposition+1)
         if surface(1,surfaceposition)== surface(1,surfaceposition-1)
              surface(2,surfaceposition)=2
              surface(3,surfaceposition)=probablityAdsorption2 
         end
         if surface(1,surfaceposition)> surface(1,surfaceposition-1)
              surface(2,surfaceposition)=2
              surface(3,surfaceposition)=probablityAdsorption2 
         end
           if surface(1,surfaceposition)< surface(1,surfaceposition-1)
              surface(2,surfaceposition)=3
              surface(3,surfaceposition)=probablityAdsorption3
           end
      end
      
     if surface(1,surfaceposition)== surface(1,surfaceposition-1)-2
         if surface(1,surfaceposition)== surface(1,surfaceposition+1)-2
            surface(3,surfaceposition)=probablityAdsorption3 -10
         end
     end
      
       if surface(1,surfaceposition)== surface(1,surfaceposition-1)-2
         if surface(1,surfaceposition)== surface(1,surfaceposition+1)-1
            surface(3,surfaceposition)=probablityAdsorption3 -5
         end
     end
      
       if surface(1,surfaceposition)== surface(1,surfaceposition+1)-2
         if surface(1,surfaceposition)== surface(1,surfaceposition-1)-1
            surface(3,surfaceposition)=probablityAdsorption3 -5
         end
       end
 
       if surface(1,surfaceposition)< surface(1,surfaceposition+1)-2
         if surface(1,surfaceposition)== surface(1,surfaceposition-1)-1
            surface(3,surfaceposition)=probablityAdsorption3 -5
         end 
       end
       
       if surface(1,surfaceposition)< surface(1,surfaceposition-1)-2
         if surface(1,surfaceposition)== surface(1,surfaceposition+1)-1
            surface(3,surfaceposition)=probablityAdsorption3 -5
         end 
       end
       
       
        if surface(1,surfaceposition)< surface(1,surfaceposition+1)-2
         if surface(1,surfaceposition)< surface(1,surfaceposition-1)-2
            surface(3,surfaceposition)=probablityAdsorption3 -10
         end 
        end
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
%       alternative
%     if surface(1,surfaceposition)< surface(1,surfaceposition+1)&& surface(1,surfaceposition)< surface(1,surfaceposition-1)
%         surface(2,surfaceposition)=3
%         surface(3,surfaceposition)=0
%     end
%     hold on
%     if surface(1,surfaceposition)== surface(1,surfaceposition+1)&& surface(1,surfaceposition)== surface(1,surfaceposition-1)
%         surface(2,surfaceposition)=1
%         surface(3,surfaceposition)=50
%    
%     end
%     hold on
%      if surface(1,surfaceposition)> surface(1,surfaceposition+1)&& surface(1,surfaceposition)> surface(1,surfaceposition-1)
%         surface(2,surfaceposition)=1
%          surface(3,surfaceposition)=50
%      end
%     hold on
%      if surface(2,surfaceposition)==0 
%        surface(2,surfaceposition)=2
%         surface(3,surfaceposition)=37.5
%      end


% creates probability for each surface atom for next etching cycle
    probability(1,surfaceposition) = surface(3,surfaceposition)
    hold on 
 end
end

 pictureTest=ones(size(X))   

%  creates 2D matrix and picture out of surface matrix
 for k=2:length_of_surface
    if surface(1,k)~=0
         pictureTest(surface(1,k),k)=1; 
         
         pictureTest(1:surface(1,k)-1,k)=0;
    end
 end
 
%   cuts the beginning and end of
 pictureTest(:,1:2)=0                 
 pictureTest(:,length_of_surface:length_of_surface+1)=0
 
  
%  creates average surface line matrix
 sum_surface=sum(surface(1,:),2)
average_surface_line=sum_surface./length_of_surface
average_surface_line_picture(1,1:length_of_surface)=average_surface_line


% creates out of the surface the standard deviation and the standard
% deviation matrix
Standard_Deviation = std(surface,0,2)
Standard_Deviation_matrix(number_of_etching+1,1)=Standard_Deviation(1);


figure;
 
% plots the average surface line in black
plot(average_surface_line_picture,'k')
hold on
spy(pictureTest,'r')



% creates a spline out of the surface and plots the spline
xx = 1:1:length_of_surface
x_values_spline =1:length_of_surface;
y_values_spline = spline(1:length_of_surface,surface(1,1:length_of_surface),xx);
y_values_spline= y_values_spline(1,1:length_of_surface)-average_surface_line

figure
plot(x_values_spline,y_values_spline,'-')

% changes the y-axis negative to create a similar illustration as the
% picture plot
axis ij 



% changes the probability of each surface atom, if it is above or beneath
% the surface line of the spline 

for surfaceposition=2:length_of_surface-1
    if y_values_spline(1,surfaceposition)<-1
         probability(1,surfaceposition)= probability(1,surfaceposition)-probabilityAdsorption_Spline
    end
end
end

% plots the standard deviation as a function over all etch cycles
figure
plot (Standard_Deviation_matrix(:,1),'k')
title('Standard Deviation over etch cycles');
xlabel('etch cycles');
ylabel('Standard Deviation');
















