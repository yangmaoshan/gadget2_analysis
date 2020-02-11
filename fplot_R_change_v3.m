
function [ave_Dispe, delta_R_over_R, kk, change_plus, change_minus, n_plus, n_minus, c_plus, c_minus, med1, med2]=fplot_R_change_v3(ni,nf,ri,rf,len,Rnumber)

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

intl=(rf-ri)/(len-1);
Store=zeros(len,1000000);
st=zeros(1,len*1000000);
Mean=zeros(1,len);
Median=zeros(1,len);
V=zeros(1,len);
Dispe=zeros(1,len);
Number=zeros(1,len);
up=zeros(1,len);
down=zeros(1,len);
kk=0;
for a=1:len
y=(abs(R(1,:)-ri-intl*(a-1))<0.1);
ss=[1, sum(y)];
T=zeros(1,ss(2));
bbb=id2(y,1);
ccc=R(1,y);
for j=1:ss(2)
    
x=bbb(j);

 n= id3(:,1)==x;
 T(j)= R(2,n)-ccc(j);
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
st(kk+1:kk+ss(2))=Store(a,1:ss(2));
kk=kk+ss(2);
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
disp(ni)
end
xx=ri:intl:rf;

ave_Dispe=(sum((Dispe.^2).*Number)/sum(Number))^0.5;
 
delta_R_over_R=(sum((Dispe.^2).*Number./(xx.^2))/sum(Number))^0.5;

%fprintf('Run %d \n ave_Dispe= %f    ,delta_R_over_R= %f \n',Rnumber,ave_Dispe,delta_R_over_R);
change=st(1:kk);
change_plus=sum(change(change>0))/kk;
change_minus=sum(change(~(change>0)))/kk;


i_p=change>ave_Dispe;
i_m=change<(-ave_Dispe);
n_plus=sum(i_p)/kk;
n_minus=sum(i_m)/kk;
nn=sum(i_p)+sum(i_m);
c_plus=sum(change(i_p))/nn;
c_minus=sum(change(i_m))/nn;

med1=median(R(1,:));
med2=median(R(2,:));

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

fname1=['Run_'  num2str(Rnumber)  '_Change' num2str(ni) '_to_' num2str(nf) '.mat'];
fname2=['Plot_Run_'  num2str(Rnumber)  '_Change' num2str(ni) '_to_' num2str(nf) '.png'];
saveas(gcf,fname2);
save(fname1,'Store','Number');
clf
end