clear
close all

n=100
[X,Y] = meshgrid(0:n, 0:10);


colors = ones(size(X)); %colors has ones everywhere besides row 1,2==0

colors(1:2, :) = 0;

for j=1:5

a=1         %parameters a and b for the probability of adsorbens number 1
b=100
 
% find starting row of 1's for each column

for i=1:length(colors)
    surface(i)=find(colors(:,i),1)
end

for n=1:length(colors)

   Z=a+(b-a).*rand(1,1);
             if Z>50
                colors2(surface(n)-1,n)=1
             else 
                 colors2(surface(n),n)=0
             end
end

colors3=zeros(size(X));
for m=1:length(colors)
      Z=a+(b-a).*rand(1,1);
             if Z>50
                colors3(surface(m)-2,m)=1
             else 
                colors3(surface(m),m)=0
             end
end
for column = 1:length(colors(1,:))
    if colors2(surface(column)-1,column) && colors3(surface(column)-2,column)==1
         surface(column) = 0;
    end
 end

hold on
                 
                 
end               
                 
                 
   % plot the grid
spy(surface,'r')
figure
hold on

spy(colors,'r')
hold on
spy(colors2,'g')
hold on
spy(colors3,'b')
hold on

xlabel('X'); % // Label the X and Y axes
ylabel('Y');
title('Initial Grid');
grid on














