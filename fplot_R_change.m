
function fplot_R_change(ni,nf,ri,rf)
ax1= subplot(2,3,1);
ax2= subplot(2,3,2);
ax3= subplot(2,3,3);
ax4= subplot(2,3,4);
ax5= subplot(2,3,5);
ax6= subplot(2,3,6);




  ij=ni;
 
  
  if ij<10
  g2=['snapshot_00' num2str(ij)  '.hdf5'];
  elseif ij<100
      g2=['snapshot_0' num2str(ij) '.hdf5'];
  else
      g2=['snapshot_' num2str(ij) '.hdf5'];
  end
 % p0=[0;0;0];
  % v0=[0;0;0];

   jj=nf;
  if jj<10
  g3=['snapshot_00' num2str(jj)  '.hdf5'];
  elseif jj<100
      g3=['snapshot_0' num2str(jj) '.hdf5'];
  else
      g3=['snapshot_' num2str(jj) '.hdf5'];
  end
  
   id2 =double( h5read(g2,'/PartType2/ParticleIDs/'));
   C2= double(h5read(g2,'/PartType2/Coordinates/'));
   id3 =double( h5read(g3,'/PartType2/ParticleIDs/'));
   C3= double(h5read(g3,'/PartType2/Coordinates/'));
  



R=zeros(2,1000000);
 

 R(1,:)= (C2(1,:).^2+ C2(2,:).^2).^0.5;
  R(2,:)  = (C3(1,:).^2+ C3(2,:).^2).^0.5;

intl=(rf-ri)/6;
Store=zeros(7,1000000);
Mean=zeros(1,7);
Median=zeros(1,7);
V=zeros(1,7);
Dispe=zeros(1,7);
Number=zeros(1,7);
up=zeros(1,7);
down=zeros(1,7);
for a=1:7
y=find(abs(R(1,:)-ri-intl*(a-1))<0.1);
ss=size(y);
T=zeros(1,ss(2));
for j=1:ss(2)
    
x=id2(y(j),1);

 n= id3(:,1)==x;
 T(j)= R(2,n)-R(1,y(j));
 Store(a,j)=T(j);  
%{
 if T(j)>2*intl
     up(a)=up(a)+1;
 end
 if T(j)< (-2*intl)
     down(a)=down(a)+1;
 end
 %}
end
Mean(a)=mean(T);
Median(a)=median(T);
V(a)=var(T);
Dispe(a)=(sum(T.^2)/ss(2))^0.5;
Number(a)=ss(2);
up(a)=sum(T> Dispe(a));
down(a)=sum(T<(- Dispe(a)));
up(a)=up(a)/ss(2);
down(a)=down(a)/ss(2);
disp(a)

end
xx=ri:intl:rf;
plot(ax1,xx,Mean);
plot(ax2,xx,Median);
plot(ax3,xx,up);
plot(ax4,xx,down);
plot(ax5,xx,V);
plot(ax6,xx,Dispe);
title(ax1,'Mean');
title(ax2,'Median');
title(ax3,'Percentage above  dispersion');
title(ax4,'Percentage below  dispersion');
title(ax5,'Variance');
title(ax6,'Dispersion');
la3='R_change.png';
saveas(gcf,la3);
fname=['Change' num2str(ni) '_to_' num2str(nf) '.mat'];
save(fname,'Store','Number');
end