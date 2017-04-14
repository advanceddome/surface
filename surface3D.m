[Z,Y] = meshgrid(-10:10);
X = 0.*Z+0.*Y+10;
C = ones(size(Z)); %You can change this behavior by specifying C when you create 
% the surface. For example, the colors on this surface vary with X.
C(1:21,20) = 2;
C(1:21,19)=3;
C(1:21,18)=4;
C(13:16,18:20)=1
C(05:08,18:20)=1
s = surf(X,Y,Z,C);
xlabel('X');
ylabel('Y');
zlabel('Z');