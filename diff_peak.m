ij=25; dds=1; ddl=10; ran_limit=0.001;



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

R=((x-c2_ave(1)).^2+ (y-c2_ave(2)).^2).^0.5;





N_strange=0;N_strange2=0;
sum=0;sum2=0;
for k=1:N_p
    r=R(:,k);
    [p, loc]=findpeaks(r);
    [p2, loc2]=findpeaks(-r);
    lp=length(p);
    
    diff_p=p(2:lp)-p(1:(lp-1));
     mean_diff=mean(abs(diff_p));
    if isnan(mean_diff)
        disp('hahaha found you')
        disp(k)
        mean_diff=0;
        N_strange=N_strange+1;
   
    end
    
    sum=sum+ mean_diff;
  
    
    
    lp2=length(p2);
    
    diff_p2=p2(2:lp2)-p2(1:(lp2-1));
     mean_diff2=mean(abs(diff_p2));
    if isnan(mean_diff2)
        disp('hahaha found you 2')
        disp(k)
        mean_diff2=0;
        N_strange2=N_strange2+1;
  
    end
    
    
   
    sum2=sum2+ mean_diff2;
    
%     if isnan(sum2)
%         disp('sum2      sum2     sum2       sum2     sum2       sum2')
%         disp(k)
%        
%     end

end

sum_t=sum/(N_p-N_strange);
sum_t2=sum2/(N_p-N_strange2);


