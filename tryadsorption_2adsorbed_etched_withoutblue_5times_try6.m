clear
close all
[X,Y] = meshgrid(0:100, 0:10);


colors = ones(size(X)); %colors has ones everywhere besides row 1,2==0

colors(1:2, :) = 0;

colors2=zeros(size(X)); % colors2 has zeros everywhere besides row 3

colors2(2,1:101)=1;
% probability of 50 percent that the surface is green.


for i=2:7
a=1         %parameters a and b for the probability of adsorbens number 1
b=100
 
    for n=1:101
         Z=a+(b-a).*rand(1,1);
             if Z>50
             colors2(i,n)=1
             else colors2(i,n)=0
             end
    end

    
colors3=zeros(size(X)); % colors3 has zeros everywhere besides row 2

colors3(1,1:101)=1 
% probability of 50 percent that the surface is blue.

a=1         %parameters a and b for the probability of adsobens number 2
b=100
 
    for m=1:101
         Y=a+(b-a).*rand(1,1);
             if Y>50
             colors3(i-1,m)=1
              
             else colors3(i-1,m)=0
                 
             end
    
    end
    hold on
%     
% %     creates only blue points, where a green point is underneath
%     for columnblue = 1:length(colors3(i,:))
%          if colors2(i+1,columnblue) && colors3(i,columnblue)==1
%          colors3(i+1,columnblue) = 1;
%          else colors3(i,columnblue) = 0;
%          end
%     end
%     
%   hold on
  
% plot the grid
spy(colors,'r')
hold on
spy(colors2,'g')
hold on 
spy(colors3,'b')

xlabel('X'); % // Label the X and Y axes
ylabel('Y');
title('Initial Grid');
grid on

  hold on
  
% removes red point underneath when blue and green points are both above
 for column = 1:length(colors2(1,:))
    if colors2(i,column) && colors3(i-1,column)==1
         colors(i+1,column) = 0;
    end
 end
 
 
 
 end


figure(4)
spy(colors,'r')
% N=5
% for n= 1:N
% for c=3:3
%     colors2(c,n)=
% 


% scatter(x,y,'k')
%     hold on
% end