
 
 
 ax1= subplot(2,3,1);
ax2= subplot(2,3,2);
ax3= subplot(2,3,3);
ax4= subplot(2,3,4);
ax5= subplot(2,3,5);
ax6= subplot(2,3,6);

M_sun= 1.989*10^30;
len_unit= 3.086*10^19;
%M_unit=M_sun*10^10* 3.39*10^(-6);
G= 6.674*10^(-11);

for ij=113:113
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
  g2= ['mysim_' num2str(ij)  '.hdf5'];
  inff=h5info(g2);
 M_unit=M_sun*10^10* inff.Groups(1).Attributes(4).Value(3);
  %{
  if ij<10
  g2=['snapshot_00' num2str(ij)  '.hdf5'];
  elseif ij<100
      g2=['snapshot_0' num2str(ij) '.hdf5'];
  else
      g2=['snapshot_' num2str(ij) '.hdf5'];
  end
  %}
  
 % p0=[0;0;0];
  % v0=[0;0;0];
  
   V1= double(h5read(g2,'/PartType0/Velocities/'));
   V2_ini= double(h5read(g2,'/PartType2/Velocities/'));
  
   
   C1=double( h5read(g2,'/PartType0/Coordinates/'));
   C2_ini= double(h5read(g2,'/PartType2/Coordinates/'));
   
   ran=rand(1,1000000);
    select=(ran<1);
    disp(sum(select))
   C2=C2_ini(1:3,select);
   V2=V2_ini(1:3,select);
   
   
   p0=mean(C2,2);
   v0=mean(V2,2);
  % M2=double(h5read(g2,'/PartType4/Masses/'));
   
 %  la1=[ 'id='  num2str(id) ',   '  'nstar='   num2str(b(3,ij)) ',   '  'condi=' num2str(b(2,ij)) ];
  % la2=[ 'relax time='   num2str(b(4,ij)) ',   '  'relax time2='   num2str(b(5,ij)) ',   ' ];
   %la3=[ 'id='  num2str(id) '.png'] ;
   
   la3=[ 'mysim_Q_select2=' num2str(ij) '.png'] ;
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
 R=20;
N=20*R;dr=R/N/2;
des=zeros(1,N);
for i=1:N
   index= find((newc2(4,:)<(dr+R/N*i))& (newc2(4,:)>=(-dr+R/N*i)));
    %dm=sum(M2(index));
    index_size=size(index);
    dm=index_size(1)+index_size(2)-1;
    des(i)=dm/pi/((dr+R/N*i)^2-(-dr+R/N*i)^2);
end
    ldes=log(des);
    ldesx=(1:N)*R/N;
    
    
    
    newv2=zeros(4,si2(2));
for i=1:si2(2)
    
    newv2(:,i)=newcoor1(unitx,unity,unitz,V2(:,i),v0);
end
veltr2=zeros(2,si2(2));

vel_z=newv2(3,:);
for i=1:si2(2)
    
    veltr2(:,i)=newvel(newc2(:,i),newv2(:,i));
end
velt2=veltr2(1,:);

vel_r2=veltr2(2,:);

N=20*R;
dr=R/N/2;
rotat=zeros(1,N);

vdisp_z=zeros(1,N);

vdisp_r=zeros(1,N);
for i=1:N
   index= find((newc2(4,:)<(dr+R/N*i))& (newc2(4,:)>=(-dr+R/N*i))&(newc2(3,:)<R/2)&(newc2(3,:)>-(R/2)));
 
    rotat(i)=mean(velt2(index));
 vdisp_r(i)=mean(vel_r2(index).^2)^0.5;
 
 vdisp_z(i)=mean(vel_z(index).^2)^0.5;
end
if mean(rotat(logical(isnan(rotat)-1)))<0
    rotat=-rotat;
end
rotatx=(1:N)*R/N;




des_sigma = des*M_unit/(len_unit^2);
omega = rotat * 1000 ./(rotatx * len_unit);

Q = vdisp_r * (1000) *2 /3.36 /G .*omega ./des_sigma;


 C_dark=double( h5read(g2,'/PartType1/Coordinates/'));
 


gsize_s=20;
gsize_g=20;

%{
ax1= subplot(2,3,1);
ax2= subplot(2,3,2);
ax3= subplot(2,3,3);
ax4= subplot(2,3,4);
ax5= subplot(2,3,5);
ax6= subplot(2,3,6);
%}
gra1=scatter(ax1,C_dark(1,:),C_dark(2,:),10,'.');
gra2=scatter(ax2,C_dark(1,:),C_dark(3,:),10,'.');
gra3=plot(ax3,ldesx,ldes);
gra4=plot(ax4,rotatx,vdisp_z);



%axis(ax1,'equal');axis(ax1,[-gsize_s+p0(1) gsize_s+p0(1) -gsize_s+p0(2) gsize_s+p0(2)]);
%axis(ax2, 'equal');axis(ax2,[-gsize_s+p0(1) gsize_s+p0(1) -gsize_s+p0(3) gsize_s+p0(3)]);

%gra5=scatter(ax5,C1(1,:),C1(2,:),10,'.');

gra5=plot(ax5,rotatx(1:(N/4)),Q(1:(N/4)));
%axis(ax5,[0 5 0 100]);
gra6=plot(ax6,rotatx,vdisp_r);
%axis(ax5,'equal'); axis(ax5,[-gsize_g+p0(1) gsize_g+p0(1) -gsize_g+p0(2) gsize_g+p0(2)]);
%axis(ax6, 'equal');axis(ax6,[-gsize_g+p0(1) gsize_g+p0(1) -gsize_g+p0(3) gsize_g+p0(3)]);

title(ax1,'stars   face on');
title(ax2,'stars   edge on');
title(ax6,'radial velocity dispersion ');
title(ax5,'Q');
title(ax3,'density');
title(ax4,'vertical velocity dispersion');
saveas(gcf,la3);
end