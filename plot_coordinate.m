%{
ax1= subplot(2,3,1);
ax2= subplot(2,3,2);
ax3= subplot(2,3,3);
ax4= subplot(2,3,4);
ax5= subplot(2,3,5);
ax6= subplot(2,3,6);
%}

for ij=0:46
%id=b(1,ij);
%cutout_request = struct('stars','Coordinates,Masses,Velocities','gas','Coordinates,Masses,Velocities');
%l='http://www.illustris-project.org/api/Illustris-1/snapshots/';
 %   ll=[l num2str(135)  '/subhalos/'  num2str(id) '/cutout.hdf5'];
  %  ll2=[l num2str(135)  '/subhalos/'  num2str(id) '/'];
  % g2=get_url(ll, cutout_request);
  % g3=get_url(ll2);
  % p0=[g3.('pos_x');g3.('pos_y');g3.('pos_z')];
  % v0=[g3.('vel_x');g3.('vel_y');g3.('vel_z')];
 
  
 
  
  if ij<10
  g2=['snapshot_00' num2str(ij)  '.hdf5'];
  elseif ij<100
      g2=['snapshot_0' num2str(ij) '.hdf5'];
  else
      g2=['snapshot_' num2str(ij) '.hdf5'];
  end
 % p0=[0;0;0];
  % v0=[0;0;0];
  
  % V1= double(h5read(g2,'/PartType0/Velocities/'));
  % V2= double(h5read(g2,'/PartType2/Velocities/'));
  
   
  % C1 =double( h5read(g2,'/PartType0/Coordinates/'));
   C2= double(h5read(g2,'/PartType2/Coordinates/'));
   
   p0=mean(C2,2);
 %  v0=mean(V2,2);
  % M2=double(h5read(g2,'/PartType4/Masses/'));
   
 %  la1=[ 'id='  num2str(id) ',   '  'nstar='   num2str(b(3,ij)) ',   '  'condi=' num2str(b(2,ij)) ];
  % la2=[ 'relax time='   num2str(b(4,ij)) ',   '  'relax time2='   num2str(b(5,ij)) ',   ' ];
   %la3=[ 'id='  num2str(id) '.png'] ;
   
   la3=[ 'snapshot_v_coordinate=' num2str(ij) '.png'] ;
  %{
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
 R=100;
N=2*R;dr=R/N/2;
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


N=5*R;
dr=R/N/2;
rotat=zeros(1,N);
for i=1:N
   index= find((newc2(4,:)<(dr+R/N*i))& (newc2(4,:)>=(-dr+R/N*i))&(newc2(3,:)<R/2)&(newc2(3,:)>-(R/2)));
 
    rotat(i)=mean(velt2(index));

end
if mean(rotat(logical(isnan(rotat)-1)))<0
    rotat=-rotat;
end
rotatx=(1:N)*R/N;




gra1=scatter(ax1,C2(1,:),C2(2,:),10);
gra2=scatter(ax2,C2(1,:),C2(3,:),10);
gra3=plot(ax3,ldesx,ldes);
gra4=plot(ax4,rotatx,rotat);



axis(ax1,'equal');axis(ax1,[-60 60 -60 60]);
axis(ax2, 'equal');axis(ax2,[-60 60 -60 60]);

gra5=scatter(ax5,C1(1,:),C1(2,:),10);
gra6=scatter(ax6,C1(1,:),C1(3,:),10);
axis(ax5,'equal'); axis(ax5,[-50 50 -50 50]);
axis(ax6, 'equal');axis(ax6,[-50 50 -50 50]);

title(ax1,'stars   face on');
title(ax2,'stars   edge on');
title(ax6,'gas   edge on');
title(ax5,'gas   face on');
title(ax3,'density');
title(ax4,'rotation curve');
%}
   disp(ij)
   gsize=50;
 scatter(C2(1,:),C2(2,:),5,'.');  
 axis('equal');axis([-gsize+p0(1) gsize+p0(1) -gsize+p0(2) gsize+p0(2)]);  
saveas(gcf,la3);
end