clear
close all

length_of_surface=100  %surfacewidth
[X,Y] = meshgrid(0:length_of_surface, 0:50);

probability=zeros(size(X))
initialmatrix = ones(size(X)); %colors has ones everywhere besides row 1,2==0
adsorption=zeros(size(X));
desorption=zeros(size(X));
initialmatrix(1:2, :) = 0;
% notice that the first 2 etch cycles do not etch they are needed to set up
% the probabilities. Number higher than 2 cause etching!!!!!!!!!!!!
% type in etchcycles in "etchcycles"

etchcycles=30

Standard_Deviation_matrix=zeros(etchcycles,1);

% adsorption
a=1         %parameters a and b for the probability of adsorbens number 1 and 2
b=100

% desorption1
c=1
d=100
% desorption2
e=1
f=100

% find starting row of 1's for each column (creates surface matrix)

for i=1:length_of_surface
    surface(i)=find(initialmatrix(:,i),1)
end
surface(2,:)=0;


% sin_curve characteristics
amplitude = 3
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

 
 
 
% starting probability for first two etch cycles
probability(1,:)=100;


%probabilities for etching
% enter probabilities in %, more than 100% means more than one layer etched
%Caution do not enter same probabilites, would double etch!!! etch
%probabiliy needs to be different!!!!!!!!!
probabilityAdsorption=100


probabilityDesorption1=115
probabilityDesorption2=120
probabilityDesorption3=125
probabilityDesorption4=90
probabilityDesorption5=102

% transfers the probabilities for calculation
probabilityAdsorption_calculate = 100-probabilityAdsorption

probablityDesorption1_calculate = 100-probabilityDesorption1;
probablityDesorption2_calculate = 100-probabilityDesorption2
probablityDesorption3_calculate = 100-probabilityDesorption3
probablityDesorption4_calculate = 100-probabilityDesorption4
probablityDesorption5_calculate = 100-probabilityDesorption5

probability_extrasputter1 = 100 + probablityDesorption1_calculate
probability_extrasputter2 = 100 + probablityDesorption2_calculate
probability_extrasputter3 = 100 + probablityDesorption3_calculate
probability_extrasputter4 = 100 + probablityDesorption4_calculate
probability_extrasputter5 = 100 + probablityDesorption5_calculate



% adds Standard Deviation in the beginning
Standard_Deviation_matrix(1,1)=calculateStandardDeviations_function(surface, length_of_surface);


% setting the etching circles
for number_of_etching=1:etchcycles

% probability of colors2=green dots to place on red (surface) ADSORPTION
for surfaceposition=2:length_of_surface
   W=a+(b-a).*rand(1,1);
             if W>probabilityAdsorption_calculate
                adsorption(surface(1,surfaceposition)-1,surfaceposition)=1
             else 
                adsorption(surface(1,surfaceposition),surfaceposition)=0
             end


% probability of colors3 =blue dots to place on the row above DESORPTION
% desorption just for the first monolayer if probablitiy is under or equal
% 100
if probability(1,surfaceposition)>-1
      Z=c+(d-c).*rand(1,1);
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

% desorption  for the first and second monolayer if probablitiy is over 
% 100%
if probability(1,surfaceposition)<-1
    if probability(1,surfaceposition) == probablityDesorption1_calculate
        surface(1,surfaceposition)= surface(1,surfaceposition)+1

        Y=c+(d-c).*rand(1,1);
             if Y>probability_extrasputter1
               
                   surface(1,surfaceposition)= surface(1,surfaceposition)+1
             end
    end
    
%     
      if probability(1,surfaceposition)== probablityDesorption2_calculate
          surface(1,surfaceposition)= surface(1,surfaceposition)+1

            YY=c+(d-c).*rand(1,1);
             if YY>probability_extrasputter2
               
                   surface(1,surfaceposition)= surface(1,surfaceposition)+1
             end
      end
      
      if probability(1,surfaceposition)== probablityDesorption3_calculate
          surface(1,surfaceposition)= surface(1,surfaceposition)+1

            ZZ=c+(d-c).*rand(1,1);
             if ZZ>probability_extrasputter3
               
                   surface(1,surfaceposition)= surface(1,surfaceposition)+1
             end
      end
        if probability(1,surfaceposition)== probablityDesorption4_calculate
          surface(1,surfaceposition)= surface(1,surfaceposition)+1

            WW=c+(d-c).*rand(1,1);
             if WW>probability_extrasputter4
               
                   surface(1,surfaceposition)= surface(1,surfaceposition)+1
             end
        end
        
        if probability(1,surfaceposition)== probablityDesorption5_calculate
          surface(1,surfaceposition)= surface(1,surfaceposition)+1

            WWW=c+(d-c).*rand(1,1);
             if WWW>probability_extrasputter5
               
                   surface(1,surfaceposition)= surface(1,surfaceposition)+1
             end
      end
end
end

% calculates the probability for each surface atom after each etch step
if number_of_etching>1
 for surfaceposition=2:length_of_surface-2
     
     if surface(1,surfaceposition)== surface(1,surfaceposition+1)
        if surface(1,surfaceposition)== surface(1,surfaceposition-1)
            surface(2,surfaceposition)=1
            surface(3,surfaceposition)=probablityDesorption1_calculate;
        end
        if surface(1,surfaceposition)< surface(1,surfaceposition-1)
            surface(2,surfaceposition)=2
            surface(3,surfaceposition)=probablityDesorption2_calculate; 
        end
        if surface(1,surfaceposition)> surface(1,surfaceposition-1)
            surface(2,surfaceposition)=1
            surface(3,surfaceposition)=probablityDesorption1_calculate;
        end
     end
     
     
     if surface(1,surfaceposition)> surface(1,surfaceposition+1)
         if surface(1,surfaceposition)== surface(1,surfaceposition-1)
              surface(2,surfaceposition)=1
              surface(3,surfaceposition)=probablityDesorption1_calculate;
         end

         if surface(1,surfaceposition)> surface(1,surfaceposition-1)
              surface(2,surfaceposition)=1
              surface(3,surfaceposition)=probablityDesorption4_calculate;
         end
         if surface(1,surfaceposition)< surface(1,surfaceposition-1)
              surface(2,surfaceposition)=2
              surface(3,surfaceposition)=probablityDesorption2_calculate;
         end
     end    
     
     
      if surface(1,surfaceposition)< surface(1,surfaceposition+1)
         if surface(1,surfaceposition)== surface(1,surfaceposition-1)
              surface(2,surfaceposition)=2
              surface(3,surfaceposition)=probablityDesorption2_calculate 
         end
         if surface(1,surfaceposition)> surface(1,surfaceposition-1)
              surface(2,surfaceposition)=2
              surface(3,surfaceposition)=probablityDesorption2_calculate 
         end
           if surface(1,surfaceposition)< surface(1,surfaceposition-1)
              surface(2,surfaceposition)=3
              surface(3,surfaceposition)=probablityDesorption3_calculate
           end
      end
      
      
if  surface(1,surfaceposition)> surface(1,surfaceposition-1)
    if surface(1,surfaceposition)== surface(1,surfaceposition+1)
        if surface(1,surfaceposition)> surface(1,surfaceposition+2)
            surface(3,surfaceposition)=probablityDesorption5_calculate
        end
    end
end

       if surface(1,surfaceposition)> surface(1,surfaceposition+1)
         if surface(1,surfaceposition)== surface(1,surfaceposition-1)
             if surface(1,surfaceposition)> surface(1,surfaceposition-2)
                 surface(2,surfaceposition)=2
                  surface(3,surfaceposition)=probablityDesorption5_calculate;
             end
         end
       end
       
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
 pictureTest(:,length_of_surface-1:length_of_surface+1)=0
 
  
%  creates average surface line matrix
 sum_surface=sum(surface(1,:),2)
average_surface_line=sum_surface./length_of_surface
average_surface_line_picture(1,1:length_of_surface)=average_surface_line


% creates out of the surface the standard deviation and the standard
% deviation matrix
Standard_Deviation = std(surface,0,2)
Standard_Deviation_matrix(number_of_etching,1)=Standard_Deviation(1);


figure;
 
% plots the average surface line in black
plot(average_surface_line_picture,'k')
hold on
spy(pictureTest,'r')

end



% plots the standard deviation as a function over all etch cycles
figure
plot (Standard_Deviation_matrix(:,1),'k')
title('Standard Deviation over etch cycles');
xlabel('etch cycles');
ylabel('Standard Deviation');
















