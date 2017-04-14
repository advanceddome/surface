clear
close all

n=100  %surfacewidth
[X,Y] = meshgrid(0:n, 0:20);


colors = ones(size(X)); %colors has ones everywhere besides row 1,2==0

colors(1:2, :) = 0;



a=1         %parameters a and b for the probability of adsorbens number 1 and 2
b=100
 

% find starting row of 1's for each column

for i=1:length(colors)
    surface(i)=find(colors(:,i),1)
end

% setting the etching circles
for number_of_etching=1:10

% probability of colors2=green dots to place on red (surface)
for n=1:length(colors)

   Z=a+(b-a).*rand(1,1);
             if Z>50
                colors2(surface(n)-1,n)=1
             else 
                colors2(surface(n),n)=0
             end
end

% probability of colors3 =blue dots to place on the row above
colors3=zeros(size(X));
for m=1:length(colors)
      W=a+(b-a).*rand(1,1);
             if W>50
                colors3(surface(m)-2,m)=1
             else 
                colors3(surface(m),m)=0
             end
end





%changes the surface, when green and blue dots are above

for column = 1:length(colors(1,:)+1)
    if colors2(surface(column)-1,column) && colors3(surface(column)-2,column)==1
         surface(1,column)= surface(1,column)+1  
        
    

     end

                 
                 
end               
end


surface(2,length(surface))=0
 for o=2:length(surface)-2
    if surface(1,o)< surface(1,o+1)&& surface(1,o)< surface(1,o-1)
        surface(2,o)=3
        surface(3,o)=25
    end
    hold on
    if surface(1,o)== surface(1,o+1)&& surface(1,o)== surface(1,o-1)
        surface(2,o)=1
        surface(3,o)=50
   
    end
    hold on
     if surface(1,o)> surface(1,o+1)&& surface(1,o)> surface(1,o-1)
        surface(2,o)=1
         surface(3,o)=50
     end
    hold on
     if surface(2,o)==0 
       surface(2,o)=2
        surface(3,o)=37.5
     end
    hold on 
 end
 
    
    
% creates out of surface (just array) a 2D spy diagramm with picture as
% function
 picture=ones(size(X))   

 for k=2:length(surface)
    if surface(1,k)~=0
         picture(surface(1,k),k)=1
         
         picture(1:surface(1,k)-1,k)=0
        
%          sideetching with a chance of 20% in the picture
% right side

        for i=3:surface(1,k)
         Er=a+(b-a).*rand(1,1);
             if Er>100
                  picture(i-2,k+1)=0
             end
        end

% left side
        for j=3:surface(1,k)
            
         El=a+(b-a).*rand(1,1);
             if El>100
                  picture(j-2,k-1)=0
             end
        end
    end
 end
 
  
 
       
     
%          
   


   % plot the grid
spy(picture,'r')

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














