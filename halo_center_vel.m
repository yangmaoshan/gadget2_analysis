for ij=0:20
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
  
   V1= double(h5read(g2,'/PartType0/Velocities/'));
   V2= double(h5read(g2,'/PartType2/Velocities/'));
   V3 =double( h5read(g2,'/PartType1/Velocities/'));
  
  
  gas=mean(V1,2);
  star=mean(V2,2);
  dark=mean(V3,2);
  

 Bg(:,:,ij+1)=gas;
   Bs(:,:,ij+1)=star;
   Bh(:,:,ij+1)=dark;
   Bt(:,:,ij+1)=dark*0.99+gas*0.01*0.5+ star*0.01*0.45;
   Bdisk(:,:,ij+1)=gas*0.01*0.5+ star*0.01*0.45;
end