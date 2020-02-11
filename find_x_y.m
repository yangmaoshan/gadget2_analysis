

 ij=20;
 x0=2;
 y0=1.8;
  dd=0.03;
  if ij<10
  g2=['snapshot_00' num2str(ij)  '.hdf5'];
  elseif ij<100
      g2=['snapshot_0' num2str(ij) '.hdf5'];
  else
      g2=['snapshot_' num2str(ij) '.hdf5'];
  end
 id2 =double( h5read(g2,'/PartType2/ParticleIDs/'));
   C2= double(h5read(g2,'/PartType2/Coordinates/'));
s = ((C2(1,:)-x0).^2+ (C2(2,:)-y0).^2).^0.5;
 con= (s<dd);
 N_p=sum(con);
 
 disp('N_P')
 disp(N_p)
 
 id_p=id2(con,1);
 x_p=C2(1,con);
 y_p=C2(2,con);
 x=zeros(100,N_p);
 y=zeros(100,N_p);
 z=zeros(100,N_p);
 
 
 
 
 
  xg=zeros(100,20);
 yg=zeros(100,20);
 zg=zeros(100,20);

 
 
 
 
for jj=21:120
    disp(jj)
  if jj<10
  g3=['snapshot_00' num2str(jj)  '.hdf5'];
  elseif jj<100
      g3=['snapshot_0' num2str(jj) '.hdf5'];
  else
      g3=['snapshot_' num2str(jj) '.hdf5'];
  end
   Cg= double(h5read(g3,'/PartType0/Coordinates/'));
  xg(jj-20,:)=Cg(1,:);
  yg(jj-20,:)=Cg(2,:);
  zg(jj-20,:)=Cg(3,:);
  
   id3 =double( h5read(g3,'/PartType2/ParticleIDs/'));
   C3= double(h5read(g3,'/PartType2/Coordinates/'));
  for ii=1:N_p
       index=id_p(ii);
       con2=id3(:,1)==index;
       x(jj-20,ii)=C3(1,con2);
       y(jj-20,ii)=C3(2,con2);
       z(jj-20,ii)=C3(3,con2);
  end
end
