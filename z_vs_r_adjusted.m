  ax1= subplot(2,2,1);
ax2= subplot(2,2,2);
  ax3= subplot(2,2,3);
ax4= subplot(2,2,4);

  for ij=11:40
  if ij<10
  g2=['snapshot_00' num2str(ij)  '.hdf5'];
  elseif ij<100
      g2=['snapshot_0' num2str(ij) '.hdf5'];
  else
      g2=['snapshot_' num2str(ij) '.hdf5'];
  end
 % p0=[0;0;0];
  % v0=[0;0;0];
  
   V1= double(h5read(g2,'/PartType0/Velocities/'));
   V2= double(h5read(g2,'/PartType2/Velocities/'));
  
   
   C1 =double( h5read(g2,'/PartType0/Coordinates/'));
   C2= double(h5read(g2,'/PartType2/Coordinates/'));
   
   p0=mean(C2,2);
   v0=mean(V2,2);
  % M2=double(h5read(g2,'/PartType4/Masses/'));
   
 %  la1=[ 'id='  num2str(id) ',   '  'nstar='   num2str(b(3,ij)) ',   '  'condi=' num2str(b(2,ij)) ];
  % la2=[ 'relax time='   num2str(b(4,ij)) ',   '  'relax time2='   num2str(b(5,ij)) ',   ' ];
   %la3=[ 'id='  num2str(id) '.png'] ;
   
   la3=[ 'snapshot_v2_z_vs_R=' num2str(ij) '.png'] ;
     xx=transpose(C2(1,:));
yy=transpose(C2(2,:));
zz=transpose(C2(3,:));
tabl=table(xx,yy,zz);
modl=fitlm(tabl);
coe=modl.Coefficients.Estimate;
coes=[coe(2); coe(3);coe(1) ] ;
ori=height(coes,p0);


cc=coes;
c=-[cc(1) cc(2) -1];
unitx=[1 0 cc(1)]/(1+cc(1)^2)^0.5;
unitz=c/norm(c);
unity=cross(unitz, unitx);

si=size(C1);
newc=zeros(4,si(2));
for i=1:si(2)
    
    newc(:,i)=newcoor1(unitx,unity,unitz,C1(:,i),ori);
end

si2=size(C2);
newc2=zeros(4,si2(2));
for i=1:si2(2)
    
    newc2(:,i)=newcoor1(unitx,unity,unitz,C2(:,i),ori);
end
    
 %   R=round(g3.('halfmassrad')/3*4);
 R=10;%R=30;%R=40;
N=20*R;%N=10*R; %N=8*R;
dr=R/N/2;
z_half=zeros(3,N);
for i=1:N
   con=((newc2(4,:)<(dr+R/N*i))& (newc2(4,:)>=(-dr+R/N*i)));
    %dm=sum(M2(index));
    z_tem=newc2(3, con);
    z_half(3,i)= median(abs(z_tem));
    z_half(1,i)= median(z_tem(z_tem>0));
    z_half(2,i)= (-1)*median(z_tem(z_tem<0));
end

    lx=(1:N)*R/N;
    
    
    scatter(ax1,newc2(4,:),newc2(3,:),1);
plot(ax2,lx,z_half(1,:));
plot(ax3,lx,z_half(2,:));
plot(ax4,lx,z_half(3,:));
    
    axis(ax2,[0 10 0 1]);
    axis(ax3,[0 10 0 1]);
    axis(ax4,[0 10 0 1]);
   saveas(gcf,la3);
   disp(ij)
  end