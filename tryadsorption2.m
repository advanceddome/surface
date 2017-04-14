clear
close all
[X,Y] = meshgrid(0:10, 0:10);


colors = ones(size(X)); %colors has ones everywhere besides row 1,2==0

colors(1:2, :) = 0;

colors2=zeros(size(X)); % colors2 has zeros everywhere besides row 1

colors2(3,1:11)=1;
% probability of 50 percent that the surface is green.
a=1         %parameters a and b for the probability
b=100
 
    for n=1:11
         X=a+(b-a).*rand(1,1);
             if X>50
             colors2(3,n)=1
             else colors2(3,n)=0
             end
    end
    
% plot the grid
spy(colors,'r')
hold on
spy(colors2,'g')

xlabel('X'); % // Label the X and Y axes
ylabel('Y');
title('Initial Grid');
grid on



    
% N=5
% for n= 1:N
% for c=3:3
%     colors2(c,n)=
% 


% scatter(x,y,'k')
%     hold on
% end