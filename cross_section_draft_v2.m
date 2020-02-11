ij=6; dds=1; ddl=5; ran_limit=0.0001; 

x0=C3_mid(1,13);
y0=C3_mid(2,13);
z0=C3_mid(3,13);
dd=0.1;

jjk=55;

  if jjk<10
  g2=['snapshot_00' num2str(jjk)  '.hdf5'];
  elseif jjk<100
      g2=['snapshot_0' num2str(jjk) '.hdf5'];
  else
      g2=['snapshot_' num2str(jjk) '.hdf5'];
  end
 id2 =double( h5read(g2,'/PartType2/ParticleIDs/'));
   C2= double(h5read(g2,'/PartType2/Coordinates/'));
   
   c2_ave=mean(C2,2);
   
   %{
  

ran=rand(1,1000000);   
s = ((C2(1,:)-c2_ave(1)).^2+ (C2(2,:)-c2_ave(2)).^2).^0.5;
 con=( (s<ddl)&(s>dds)&(ran<ran_limit));
 N_p=sum(con);
 
 
 %}
 
 
 
s = ((C2(1,:)-x0).^2+ (C2(2,:)-y0).^2+(C2(3,:)-z0).^2).^0.5;
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
 
 
 
for jj=(ij+1):(ij+100)
    disp(jj)
  if jj<10
  g3=['snapshot_00' num2str(jj)  '.hdf5'];
  elseif jj<100
      g3=['snapshot_0' num2str(jj) '.hdf5'];
  else
      g3=['snapshot_' num2str(jj) '.hdf5'];
  end
   
  
   id3 =double( h5read(g3,'/PartType2/ParticleIDs/'));
   C3= double(h5read(g3,'/PartType2/Coordinates/'));
  for ii=1:N_p
       index=id_p(ii);
       con2=id3(:,1)==index;
       x(jj-ij,ii)=C3(1,con2);
       y(jj-ij,ii)=C3(2,con2);
       z(jj-ij,ii)=C3(3,con2);
  end
end

