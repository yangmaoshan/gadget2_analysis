for ij=0:30
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
   V1= double(h5read(g2,'/PartType2/ParticleIDs/'));
   V2= double(h5read(g2,'/PartType2/Velocities/'));
  
   
   C1 =double( h5read(g2,'/PartType0/ParticleIDs/'));
   C2= double(h5read(g2,'/PartType2/Coordinates/'));
   Av1(:,:,ij+1)=V1;
   Av2(:,:,ij+1)=V2;
   Ac1(:,:,ij+1)=C1;
   Ac2(:,:,ij+1)=C2;

end

R=zeros(31,1000000);
for i=1:31

 R(i,:)= (Ac2(1,:,i).^2+ Ac2(2,:,i).^2).^0.5;
    

end
Store=zeros(7,1000000);
for a=1:7
y=find(abs(R(6,:)-a)<0.1);
ss=size(y);
T=zeros(1,ss(2));
for j=1:ss(2)
    
x=Av1(y(j),1,6);

 n=find(Av1(:,1,16)==x);
 T(j)= R(16,n)-R(6,y(j));
 Store(a,j)=T(j);  


end
Mean(a)=mean(T);
Median(a)=median(T);
V(a)=var(T);
Dispe(a)=sum(T.^2)/ss(2);
Number(a)=ss(2);
disp(a)


end