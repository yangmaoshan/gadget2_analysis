clf
ax1= subplot(1,2,1);
ax2= subplot(1,2,2);
L_sum=zeros(1, 40);
L_sum_simple=zeros(1, 40);
L_gas_sum=zeros(1, 40);
for ij=0:39
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
   V2= double(h5read(g2,'/PartType2/Velocities/'));
  
   
   C1 =double( h5read(g2,'/PartType0/Coordinates/'));
   C2= double(h5read(g2,'/PartType2/Coordinates/'));
   
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
    
c2_simple=zeros(2,si2(2));
c2_simple(1,:)=C2(1,:)-p0(1);
c2_simple(2,:)=C2(2,:)-p0(2);
    
    vtr2_simple=zeros(2,si2(2));
 for i=1:si2(2)
    
    vtr2_simple(:,i)=newvel(c2_simple(:,i),V2(:,i));
 end   
L_star_simple=vtr2_simple(1,:).*(c2_simple(1,:).^2+c2_simple(2,:).^2).^0.5;
L_sum_simple(ij+1)=sum(L_star_simple);

 
 

c1_simple=zeros(2,si(2));
c1_simple(1,:)=C1(1,:)-p0(1);
c1_simple(2,:)=C1(2,:)-p0(2);
    
    vtr1_simple=zeros(2,si(2));
 for i=1:si(2)
    
    vtr1_simple(:,i)=newvel(c1_simple(:,i),V1(:,i));
 end   
L_gas_simple=vtr1_simple(1,:).*(c1_simple(1,:).^2+c1_simple(2,:).^2).^0.5;
L_gas_sum(ij+1)=sum(L_gas_simple);




 
    newv2=zeros(4,si2(2));
for i=1:si2(2)
    
    newv2(:,i)=newcoor1(unitx,unity,unitz,V2(:,i),v0);
end
veltr2=zeros(2,si2(2));
for i=1:si2(2)
    
    veltr2(:,i)=newvel(newc2(:,i),newv2(:,i));
end
velt2=veltr2(1,:);



L_star=velt2.*newc2(4,:);

L_sum(ij+1)=sum(L_star);



end
plot(ax1, L_gas_sum);
plot(ax2, L_sum_simple)
 la3=[ 'L_star_total'  '.png'] ;
saveas(gcf, la3);