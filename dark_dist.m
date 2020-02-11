ax1= subplot(2,2,1);
ax2= subplot(2,2,2);
ax3= subplot(2,2,3);
ax4= subplot(2,2,4);
%ax5= subplot(2,3,5);
%ax6= subplot(2,3,6);

M_sun= 1.989*10^30;
len_unit= 3.086*10^19;
%M_unit=M_sun*10^10* 3.39*10^(-6);
G= 6.674*10^(-11);


  g2_= ['snapshot_000'  '.hdf5'];
  inff=h5info(g2_);
 M_unit=M_sun*10^10* inff.Groups(1).Attributes(4).Value(3);



for ij=0:38
%id=b(1,ij);
%cutout_request = struct('stars','Coordinates,Masses,Velocities','gas','Coordinates,Masses,Velocities');
%l='http://www.illustris-project.org/api/Illustris-1/snapshots/';
 %   ll=[l num2str(135)  '/subhalos/'  num2str(id) '/cutout.hdf5'];
  %  ll2=[l num2str(135)  '/subhalos/'  num2str(id) '/'];
  % g2=get_url(ll, cutout_request);
  % g3=get_url(ll2);
  % p0=[g3.('pos_x');g3.('pos_y');g3.('pos_z')];
  % v0=[g3.('vel_x');g3.('vel_y');g3.('vel_z')];
 
  disp(ij)
 
  
  
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
   V2_ini= double(h5read(g2,'/PartType1/Velocities/'));
  
   
   C1=double( h5read(g2,'/PartType0/Coordinates/'));
   C2_ini= double(h5read(g2,'/PartType1/Coordinates/'));
   
   ran=rand(1,970000);
    select=(ran<0.1);
    disp(sum(select))
   C2=C2_ini(1:3,select);
   V2=V2_ini(1:3,select);
   
   
   p0=mean(C2,2);
   v0=mean(V2,2);
  % M2=double(h5read(g2,'/PartType4/Masses/'));
   
 %  la1=[ 'id='  num2str(id) ',   '  'nstar='   num2str(b(3,ij)) ',   '  'condi=' num2str(b(2,ij)) ];
  % la2=[ 'relax time='   num2str(b(4,ij)) ',   '  'relax time2='   num2str(b(5,ij)) ',   ' ];
   %la3=[ 'id='  num2str(id) '.png'] ;
   
   la3=[ 'snapshot_vdisp_dark_select2=' num2str(ij) '.png'] ;
    


si2=size(C2);

C2_R= (C2(1,:).^2+C2(2,:).^2+ C2(3,:).^2).^0.5;


  newv2=zeros(1,si2(2));
for i=1:si2(2)
    
    newv2(i)=dot(V2(:,i),C2(:,i))/C2_R(i);
end

 R=400;
N=2*R;dr=R/N/2;
des=zeros(1,N);
V2_R=zeros(1,N);
for i=1:N
   Sel=((C2_R<(dr+R/N*i))& (C2_R>=(-dr+R/N*i)));
     
    dm=sum(Sel);
     V2_R(i)=sum(newv2(Sel))/dm;
    des(i)=dm/((dr+R/N*i)^3-(-dr+R/N*i)^3);
end
    ldes=log(des);
    ldesx=(1:N)*R/N;
    
    
    
 








gsize_s=400;
gsize_g=200;


gra1=scatter(ax1,C2(1,:),C2(2,:),10,'.');
gra2=scatter(ax2,C2(1,:),C2(3,:),10,'.');
gra3=plot(ax3,ldesx,ldes);
gra4=plot(ax4,ldesx,V2_R);



axis(ax1,'equal');axis(ax1,[-gsize_s+p0(1) gsize_s+p0(1) -gsize_s+p0(2) gsize_s+p0(2)]);
axis(ax2, 'equal');axis(ax2,[-gsize_s+p0(1) gsize_s+p0(1) -gsize_s+p0(3) gsize_s+p0(3)]);



title(ax1,'dark   face on');
title(ax2,'dark  edge on');

title(ax3,'density');
%title(ax4,'radial velocity ');
saveas(gcf,la3);
end