clear
close all

length_of_surface=100  %surfacewidth
[X,Y] = meshgrid(0:length_of_surface, 0:20);

probability=zeros(size(X))
initialmatrix = ones(size(X)); %colors has ones everywhere besides row 1,2==0
adsorption=zeros(size(X));
desorption=zeros(size(X));
initialmatrix(1:2, :) = 0;
etchcycles=3
Standard_Deviation_matrix=zeros(etchcycles,1);


a=1         %parameters a and b for the probability of adsorbens number 1 and 2
b=100
 

% find starting row of 1's for each column (creates surface matrix)


for i=1:length_of_surface
    surface(i)=find(initialmatrix(:,i),1)
end
surface(2,:)=0;


periodicity = 10;

% surface shape of sine
for i=1:length_of_surface
surface(1,i) = round((sin(i.*2.*pi/periodicity)))+4;
end

 
 plot (surface(1,1:length_of_surface),'k')


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
probablityAdsorption1 = 50;
probablityAdsorption2 = 37.5;
probablityAdsorption3 = 0;


calculateStandardDeviations(surface)

% sum_surface=sum(surface(1,:),2)
% average_surface_line=sum_surface./length_of_surface
% average_surface_line_picture(1,1:length_of_surface)=average_surface_line
% 
% 
% Standard_Deviation = std(surface,0,2)
% Standard_Deviation_matrix(1,1)=Standard_Deviation(1);




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
 
  
 
 sum_surface=sum(surface(1,:),2)
average_surface_line=sum_surface./length_of_surface
average_surface_line_picture(1,1:length_of_surface)=average_surface_line


Standard_Deviation = std(surface,0,2)
Standard_Deviation_matrix(number_of_etching+1,1)=Standard_Deviation(1);

figure;
 

plot(average_surface_line_picture,'k')
hold on
spy(pictureTest,'r')

 

end
figure
plot (Standard_Deviation_matrix(:,1),'k')
title('Standard Deviation over etch cycles');
xlabel('etch cycles');
ylabel('Standard Deviation');





% creates out of surface (just array) a 2D spy diagramm with picture as
% function
%  picture=ones(size(X))   
% 
%  for k=2:length_of_surface
%     if surface(1,k)~=0
%          picture(surface(1,k),k)=1
%          
%          picture(1:surface(1,k)-1,k)=0
%     end
%  end
 
 
%          sideetching with a chance of 20% in the picture
% right side

%         for i=3:surface(1,k)
%          sideetching_right=a+(b-a).*rand(1,1);
%              if sideetching_right>100
%                   picture(i-2,k+1)=0
%              end
%         end
% 
% % left side
%         for j=3:surface(1,k)
%             
%          sideetching_left=a+(b-a).*rand(1,1);
%              if sideetching_left>100
%                   picture(j-2,k-1)=0
%              end
%         end
%     end
%  end
 
 
%  surface(2,length(surface))=0
%  for o=2:length(surface)-2
%     if surface(1,o)< surface(1,o+1)&& surface(1,o)< surface(1,o-1)
%         surface(2,o)=3
%     end
%     hold on
%     if surface(1,o)== surface(1,o+1)&& surface(1,o)== surface(1,o-1)
%         surface(2,o)=1
%     end
%     hold on
%      if surface(1,o)> surface(1,o+1)&& surface(1,o)> surface(1,o-1)
%         surface(2,o)=1
%      end
%     hold on
%      if surface(2,o)==0 
%        surface(2,o)=2
%        
%     end
%     hold on
%  end

 
%   for i=1:length(colors)
%    
%     surface(2,i)=find(picture(3:21,i),0)
% end
%          
%    


   % plot the grid
% spy(picture,'r')

% spy(surface,'r')
% figure
% hold on
% 
% spy(colors,'r')
% hold on
% spy(colors2,'g')
% hold on
% spy(colors3,'b')
% hold on
% 
% xlabel('X'); % // Label the X and Y axes
% ylabel('Y');
% title('Initial Grid');
% grid on














