%net1



%net84


%with unstable


%without unstable
set(gca,'ZTick',[])
view(-1,72)
zlabel('')
axis([.6 20 .005 20 .005 20])
set(gca,'GridLineStyle','--')
set(gca,'XTick',[.1 1 10])
set(gca,'YTick',[.1 1 10])
print -depsc 'net84_00_Uc_noZ_-1_72'