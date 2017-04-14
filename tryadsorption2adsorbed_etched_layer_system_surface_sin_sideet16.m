clear all
surfacelength=100
layer(1:surfacelength,1)=1:100
layer(1:surfacelength,2)=20

periodicity = 20;

% surface shape of sine
for i=1:surfacelength
   layer(i,2) = (sin(i.*2.*pi/periodicity))+20; 
end
figure;

plot (layer(1:surfacelength,2),'k')



surface=layer
surface(1:surfacelength,3)=0

% for x=1:100
% layer(1:surfacelength,2)=sin(x)
% end


a=1
b=100
cycles=10

for j=1:cycles
for m=1:surfacelength
      Z=a+(b-a).*rand(1,1);
             if Z>50
                surface(m,3)=1
             else 
                surface(m,3)=0
             end
end



for n=1:surfacelength
      Z=a+(b-a).*rand(1,1);
             if Z>50
                 if surface(n,3)==1
                    surface(n,3)=2
                 end
            
             end
end

for o=1:surfacelength
    if surface(o,3)==2
        surface(o,2)= surface(o,2)-1
        surface(o,3)=0
    end
end

%          sideetching with a chance of 20% in the picture

% right side

        for j=2:surfacelength-1
         Er=a+(b-a).*rand(1,1);
             if Er>75
                layer(j+1,2)=layer(j+1,2)-1
             end
        end

% left side
        for k=2:surfacelength
            
         El=a+(b-a).*rand(1,1);
             if El>75
                  layer(k-1,2)=layer(k-1,2)-1
             end
        end

 layer=surface(1:100,1:2)
hold on
end


plot (layer(1:surfacelength,2),'k')


