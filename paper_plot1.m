 g2_= ['snapshot_000'  '.hdf5']; %9/18, folder Run118_8_19
  inff=h5info(g2_);
 M_unit= inff.Groups(1).Attributes(4).Value(3);
countt=1;
for ij=0:5:15
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
   V2_ini= double(h5read(g2,'/PartType2/Velocities/'));
  
   
   C1 =double( h5read(g2,'/PartType0/Coordinates/'));
   C2_ini= double(h5read(g2,'/PartType2/Coordinates/'));
   
   ran=rand(1,1000000); 
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
 R=20;%R=30;%R=40;
N=20*R;%N=10*R; %N=8*R;
dr=R/N/2;
des=zeros(1,N);
for i=1:N
   index= find((newc2(4,:)<(dr+R/N*i))& (newc2(4,:)>=(-dr+R/N*i)));
    %dm=sum(M2(index));
    index_size=size(index);
    dm=index_size(1)+index_size(2)-1;
    des(i)=10*M_unit*10^4* dm/pi/((dr+R/N*i)^2-(-dr+R/N*i)^2);
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


N=20*R;%N=10*R;%N=8*R;
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


gsize_s=18;%gsize_s=25;gsize_s=20;
gsize_g=18;%gsize_g=30;

title_t = ['   Time=', num2str(ij*50), ' Myr']; 
gra1=scatter(subplot(4,4, countt),C2(1,:),C2(2,:),10,'.');
gra1.MarkerEdgeAlpha = 0.1;
axis(subplot(4,4, countt),'equal');axis(subplot(4,4, countt),[-gsize_s+p0(1) gsize_s+p0(1) -gsize_s+p0(2) gsize_s+p0(2)]);
xlabel(subplot(4,4, countt), 'X (kpc) ');
ylabel(subplot(4,4, countt), 'Y (kpc) ');


countt= countt+1;
scatter(subplot(4,4, countt),C1(1,:),C1(2,:),10,'o');


axis(subplot(4,4, countt),'equal'); axis(subplot(4,4, countt),[-gsize_g+p0(1) gsize_g+p0(1) -gsize_g+p0(2) gsize_g+p0(2)]);
xlabel(subplot(4,4, countt), 'X (kpc) ');
ylabel(subplot(4,4, countt), 'Y (kpc) ');

countt= countt+1;



gra2=scatter(subplot(4,4, countt),C2(1,:),C2(3,:),10,'.');
gra2.MarkerEdgeAlpha = 0.1;
axis(subplot(4,4, countt),'equal');axis(subplot(4,4, countt),[-gsize_s+p0(1) gsize_s+p0(1) -gsize_s+p0(2) gsize_s+p0(2)]);
xlabel(subplot(4,4, countt), 'X (kpc) ');
ylabel(subplot(4,4, countt), 'Z (kpc) ');

countt= countt+1;



plot(subplot(4,4, countt),ldesx,ldes);
axis(subplot(4,4, countt),[0 20 -9 5]);

%axis(ax{countt},[0 14 -5 7]);
xlabel(subplot(4,4, countt), 'R (kpc) ');
ylabel(subplot(4,4, countt), 'ln(surface density in M_{sun}/pc^2)');
%{
gra2=scatter(ax2,C2(1,:),C2(3,:),10,'.');
gra2.MarkerEdgeAlpha = 0.1;
gra3=plot(ax3,ldesx,ldes);
gra4=plot(ax4,rotatx,rotat);
axis(ax4,[0 15 0 150]);
axis(ax3,[0 20 -6 13.5]);%axis(ax3,[0 20 -6 12])

axis(ax1,'equal');axis(ax1,[-gsize_s+p0(1) gsize_s+p0(1) -gsize_s+p0(2) gsize_s+p0(2)]);
axis(ax2, 'equal');axis(ax2,[-gsize_s+p0(1) gsize_s+p0(1) -gsize_s+p0(3) gsize_s+p0(3)]);

gra5=scatter(ax5,C1(1,:),C1(2,:),10,'.');
gra6=scatter(ax6,C1(1,:),C1(3,:),10,'.');
gra5.MarkerEdgeAlpha = 0.5;
gra6.MarkerEdgeAlpha = 0.5;

axis(ax5,'equal'); axis(ax5,[-gsize_g+p0(1) gsize_g+p0(1) -gsize_g+p0(2) gsize_g+p0(2)]);
axis(ax6, 'equal');axis(ax6,[-gsize_g+p0(1) gsize_g+p0(1) -gsize_g+p0(3) gsize_g+p0(3)]);

title_t = ['   Time=', num2str(ij*50), ' Myr']; 

title(ax{countt},title_t );
xlabel(ax{countt}, 'X (kpc) ');
ylabel(ax{countt}, 'Y (kpc) ');
%}
countt=countt+1;
%{
title(ax2,['stars   edge on' , title_t ]);
xlabel(ax2, 'X (kpc) ');
ylabel(ax2, 'Z (kpc) ');
title(ax6,['gas   edge on' , title_t ]);
xlabel(ax6, 'X (kpc) ');
ylabel(ax6, 'Z (kpc) ');
title(ax5,['gas   face on', title_t ]);
xlabel(ax5, 'X (kpc) ');
ylabel(ax5, 'Y (kpc) ');
title(ax3,['surface density vs. R', title_t ]);
xlabel(ax3, 'R (kpc) ');
ylabel(ax3, 'lg (surface density) ');
title(ax4,['rotation curve', title_t ]);
xlabel(ax4, 'R (kpc) ');
ylabel(ax4, 'rotational velocity (km/s) ');
%}
end

 la3=[ 'snapshot_all_denity'  '.png'] ;
 saveas(gcf,la3);