[X,Y] = meshgrid(0:10, 0:10);


colors = ones(size(X));

colors(1:2, :) = 0;

colors(:, 6:8) = 3;
colors2=zeros(size(X));
colors2(1:3,5)=1;
colors2(3,1:5)=1;
colors2(1,5:8)=1;
colors2(1:3,8)=1;
colors2(3,8:11)=1
spy(colors,'r')
hold on
spy(colors2,'g')

xlabel('X'); % // Label the X and Y axes
ylabel('Y');
title('Initial Grid');
grid on