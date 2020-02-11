ax1= subplot(2,3,1);
ax2= subplot(2,3,2);
ax3= subplot(2,3,3);
ax4= subplot(2,3,4);
ax5= subplot(2,3,5);
ax6= subplot(2,3,6);


for ij=1:1
%id=b(1,ij);
%cutout_request = struct('stars','Coordinates,Masses,Velocities','gas','Coordinates,Masses,Velocities');
%l='http://www.illustris-project.org/api/Illustris-1/snapshots/';
 %   ll=[l num2str(135)  '/subhalos/'  num2str(id) '/cutout.hdf5'];
  %  ll2=[l num2str(135)  '/subhalos/'  num2str(id) '/'];
  % g2=get_url(ll, cutout_request);
  % g3=get_url(ll2);
  % p0=[g3.('pos_x');g3.('pos_y');g3.('pos_z')];
  % v0=[g3.('vel_x');g3.('vel_y');g3.('vel_z')];
  
  g2=['mysim_01xm_10xg_10_44'   '.hdf5'];
  
  p0=[0;0;0];
   v0=[0;0;0];
  
   V1= double(h5read(g2,'/PartType0/Velocities/'));
   V2= double(h5read(g2,'/PartType2/Velocities/'));
  V3= double(h5read(g2,'/PartType1/Velocities/'));
   
   C1 =double( h5read(g2,'/PartType0/Coordinates/'));
   C2= double(h5read(g2,'/PartType2/Coordinates/'));
    C3= double(h5read(g2,'/PartType1/Coordinates/'));
    
   %p0=mean(C1,2);
   %v0=mean(V2,2);
  % M2=double(h5read(g2,'/PartType4/Masses/'));
   
 %  la1=[ 'id='  num2str(id) ',   '  'nstar='   num2str(b(3,ij)) ',   '  'condi=' num2str(b(2,ij)) ];
  % la2=[ 'relax time='   num2str(b(4,ij)) ',   '  'relax time2='   num2str(b(5,ij)) ',   ' ];
   %la3=[ 'id='  num2str(id) '.png'] ;
   
   la3=[ 'snapshot=mysim_run44_vdisp'  '.png'] ;
     xx=transpose(C1(1,:));
yy=transpose(C1(2,:));
zz=transpose(C1(3,:));
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
 R=35;
N=50;dr=R/N/2;
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
for i=1:si2(2)
    
    veltr2(:,i)=newvel(newc2(:,i),newv2(:,i));
end
velt2=veltr2(1,:);
vel_r2=veltr2(2,:);

N=100;
dr=R/N/2;
rotat=zeros(1,N);
vdisp_r=zeros(1,N);




  
    newv=zeros(4,si(2));
for i=1:si(2)
    
    newv(:,i)=newcoor1(unitx,unity,unitz,V1(:,i),v0);
end
veltr=zeros(2,si(2));
for i=1:si(2)
    
    veltr(:,i)=newvel(newc(:,i),newv(:,i));
end
velt=veltr(1,:);
vel_r=veltr(2,:);


rotat_g=zeros(1,N);
vdisp_r_g=zeros(1,N);






for i=1:N
   index= find((newc2(4,:)<(dr+R/N*i))& (newc2(4,:)>=(-dr+R/N*i))&(newc2(3,:)<R/2)&(newc2(3,:)>-(R/2)));
  index_g= find((newc(4,:)<(dr+R/N*i))& (newc(4,:)>=(-dr+R/N*i))&(newc(3,:)<R/2)&(newc(3,:)>-(R/2)));
  
    rotat(i)=mean(velt2(index));
   vdisp_r(i)=mean(vel_r2(index).^2)^0.5;
     rotat_g(i)=mean(velt(index_g));
   vdisp_r_g(i)=mean(vel_r(index_g).^2)^0.5;
   
end


if mean(rotat_g(logical(isnan(rotat_g)-1)))<0
    rotat_g=-rotat_g;
end

if mean(rotat(logical(isnan(rotat)-1)))<0
    rotat=-rotat;
end
rotatx=(1:N)*R/N;



%{
ax1= subplot(2,3,1);
ax2= subplot(2,3,2);
ax3= subplot(2,3,3);
ax4= subplot(2,3,4);
ax5= subplot(2,3,5);
ax6= subplot(2,3,6);
%}
gra1=scatter(ax1,newc2(1,:),newc2(2,:),10);
gra2=scatter(ax2,newc2(1,:),newc2(3,:),10);
gra3=plot(ax3,rotatx,vdisp_r);
gra4=plot(ax4,rotatx,rotat);
axis(ax1,'equal');
axis(ax2, 'equal');

gra5=plot(ax5,rotatx,vdisp_r_g);
gra6=plot(ax6,rotatx,rotat_g);


title(ax1,'stars   face on');
title(ax2,'stars   edge on');
title(ax6,'gas rotation curve ');
title(ax5,'gas   vdisp');
title(ax3,'vdisp');
title(ax4,'rotation curve');
saveas(gcf,la3);
end