

ij=25; dds=1; ddl=10; ran_limit=0.0001; n_gas=200; dist_limit=0.3;



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
 x=zeros(100,N_p);
 y=zeros(100,N_p);
 z=zeros(100,N_p);
 
 
 xg=zeros(100,n_gas);
 yg=zeros(100,n_gas);
 zg=zeros(100,n_gas);
 
 
 
 
 
 
for jj=(ij+1):(ij+100)
    disp(jj)
  if jj<10
  g3=['snapshot_00' num2str(jj)  '.hdf5'];
  elseif jj<100
      g3=['snapshot_0' num2str(jj) '.hdf5'];
  else
      g3=['snapshot_' num2str(jj) '.hdf5'];
  end
   
  Cg= double(h5read(g3,'/PartType0/Coordinates/'));
  xg(jj-ij,:)=Cg(1,:);
  yg(jj-ij,:)=Cg(2,:);
  zg(jj-ij,:)=Cg(3,:);
  
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



Dist=zeros(100,N_p);
for k=1:N_p
    
        for kk=1:100
            t=kk;
            
            dist=((xg(t,:)-x(t,k)).^2+(yg(t,:)-y(t,k)).^2+(zg(t,:)-z(t,k)).^2).^0.5;
            
            Dist(kk,k)=min(dist);
            
        end
     
end




R=((x-c2_ave(1)).^2+ (y-c2_ave(2)).^2).^0.5;
OCC=zeros(1,N_p);
IND=zeros(100,N_p);

OCC_r=zeros(1,N_p);
IND_r=zeros(100,N_p);
N_scatter=0;
for k=1:N_p
    r=R(:,k);
    [p, loc]=findpeaks(r);
    [p2, loc2]=findpeaks(-r);
    lo=[loc;loc2];
    [occ,ind]=find_scatter_v4(p, -p2, loc,loc2);
    OCC(k)=occ;
    IND(:,k)=ind;
    % ind_check=(ind > (jjk-ij)-5)& (ind < (jjk-ij)+5);
    if (occ>0) 
        kkk=0;
    for kk=1:occ
        low=max(1,ind(kk)-5);
        high=min(100,ind(kk)+5);
        con_d=(Dist(low:high,k)<dist_limit);
        
        if sum(con_d)>0.5
            kkk=kkk+1;
            IND_r(kkk,k)=ind(kk);
        end
        
        
    end
    
    OCC_r(k)=kkk;
    
    
        disp(k)
        N_scatter=N_scatter+1;
    end
    
    

end
ratio_occ=sum(OCC)/N_p;
ratio_occ_r=sum(OCC_r)/N_p;

ratio=N_scatter/N_p;