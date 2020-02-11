ij=15; dds=5.5; ddl=5.6; ran_limit=0.1; n_gas=200;   step=3; 
%affected_tstep=25; dist_limit=0.3;


if ij<10
  g2=['snapshot_00' num2str(ij)  '.hdf5'];
  elseif ij<100
      g2=['snapshot_0' num2str(ij) '.hdf5'];
  else
      g2=['snapshot_' num2str(ij) '.hdf5'];
end
 id2 =double( h5read(g2,'/PartType2/ParticleIDs/'));
   C2= double(h5read(g2,'/PartType2/Coordinates/'));
   
   
   
   c2_ave=mean(C2,2);

ran=rand(1,1000000);   
s = ((C2(1,:)-c2_ave(1)).^2+ (C2(2,:)-c2_ave(2)).^2).^0.5;
 con=( (s<ddl)&(s>dds)&(ran<ran_limit));
 N_p=sum(con);
 
 disp('N_P')
 disp(N_p)
 
 id_p=id2(con,1);
 x_p=C2(1,con);
 y_p=C2(2,con);
 x=zeros(step,N_p);
 y=zeros(step,N_p);
 z=zeros(step,N_p);
 
 x_ori=zeros(step,N_p);
 y_ori=zeros(step,N_p);
 
 xg=zeros(step,n_gas);
 yg=zeros(step,n_gas);
 zg=zeros(step,n_gas);
 
 
 
 
 
 
for jj=(ij+1):(ij+step)
    jjj=ij+(jj-ij)*5;
    disp(jjj)
  if jjj<10
  g3=['snapshot_00' num2str(jjj)  '.hdf5'];
  elseif jjj<100
      g3=['snapshot_0' num2str(jjj) '.hdf5'];
  else
      g3=['snapshot_' num2str(jjj) '.hdf5'];
  end
   
  Cg= double(h5read(g3,'/PartType0/Coordinates/'));
  xg(jj-ij,:)=Cg(1,:);
  yg(jj-ij,:)=Cg(2,:);
  zg(jj-ij,:)=Cg(3,:);
  
   id3 =double( h5read(g3,'/PartType2/ParticleIDs/'));
   C3= double(h5read(g3,'/PartType2/Coordinates/'));
   c3_ave=mean(C3,2);
   x_ori(jj-ij,:)=c3_ave(1);
   y_ori(jj-ij,:)=c3_ave(2);
  for ii=1:N_p
      
      if mod(ii,10000)==0
          disp (ii/10000)
      end
       index=id_p(ii);
       con2=id3(:,1)==index;
       x(jj-ij,ii)=C3(1,con2);
       y(jj-ij,ii)=C3(2,con2);
       z(jj-ij,ii)=C3(3,con2);
  end
end
