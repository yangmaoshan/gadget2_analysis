for ij=40:41
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
   disp(ij);
  % V1= double(h5read(g2,'/PartType2/ParticleIDs/'));
   %V2= double(h5read(g2,'/PartType2/Velocities/'));
  
   
   Cs =double( h5read(g2,'/PartType2/Coordinates/'));
   Ch= double(h5read(g2,'/PartType1/Coordinates/'));
  
  ps=mean(Cs,2);
  ph=mean(Ch,2);


   Bs(:,:,ij+1)=ps;
   Bh(:,:,ij+1)=ph;
  % v0=mean(V2,2);
  % M2=double(h5read(g2,'/PartType4/Masses/'));
   
 %  la1=[ 'id='  num2str(id) ',   '  'nstar='   num2str(b(3,ij)) ',   '  'condi=' num2str(b(2,ij)) ];
  % la2=[ 'relax time='   num2str(b(4,ij)) ',   '  'relax time2='   num2str(b(5,ij)) ',   ' ];
   %la3=[ 'id='  num2str(id) '.png'] ;
   %{
 
   la3=[ 'snapshot_v2=' num2str(ij) '.png'] ;
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
    

 R=20;
N=20*R;
dr=R/N/2;
des=zeros(1,N);
for i=1:N
   index= find((newc2(4,:)<(dr+R/N*i))& (newc2(4,:)>=(-dr+R/N*i)));
   
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


N=20*R;
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

disp(ij)
gsize_s=10;
gsize_g=10;


gra1=scatter(ax1,C2(1,:),C2(2,:),10,'.');
gra2=scatter(ax2,C2(1,:),C2(3,:),10,'.');
gra3=plot(ax3,ldesx,ldes);
gra4=plot(ax4,rotatx,rotat);

axis(ax3,[0 20 -6 12]);

axis(ax1,'equal');axis(ax1,[-gsize_s+p0(1) gsize_s+p0(1) -gsize_s+p0(2) gsize_s+p0(2)]);
axis(ax2, 'equal');axis(ax2,[-gsize_s+p0(1) gsize_s+p0(1) -gsize_s+p0(3) gsize_s+p0(3)]);


gra5=scatter(ax5,C1(1,:),C1(2,:),5);
gra6=scatter(ax6,C1(1,:),C1(3,:),5);
axis(ax5,'equal'); axis(ax5,[-gsize_g+p0(1) gsize_g+p0(1) -gsize_g+p0(2) gsize_g+p0(2)]);
axis(ax6, 'equal');axis(ax6,[-gsize_g+p0(1) gsize_g+p0(1) -gsize_g+p0(3) gsize_g+p0(3)]);

title(ax1,'stars   face on');
title(ax2,'stars   edge on');
title(ax6,'gas   edge on');
title(ax5,'gas   face on');
title(ax3,'density');
title(ax4,'rotation curve');
saveas(gcf,la3);
   %}
end