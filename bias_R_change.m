function bias_R_change(ni,nf,ri,rf,len,ran_limit)


clf


  ij=ni;
 
  
  if ij<10
  g2=['snapshot_00' num2str(ij)  '.hdf5'];
  elseif ij<100
      g2=['snapshot_0' num2str(ij) '.hdf5'];
  else
      g2=['snapshot_' num2str(ij) '.hdf5'];
  end
 % p0=[0;0;0];
  % v0=[0;0;0];

   jj=nf;
  if jj<10
  g3=['snapshot_00' num2str(jj)  '.hdf5'];
  elseif jj<100
      g3=['snapshot_0' num2str(jj) '.hdf5'];
  else
      g3=['snapshot_' num2str(jj) '.hdf5'];
  end
  
   id2 =double( h5read(g2,'/PartType2/ParticleIDs/'));
   C2= double(h5read(g2,'/PartType2/Coordinates/'));
   id3 =double( h5read(g3,'/PartType2/ParticleIDs/'));
   C3= double(h5read(g3,'/PartType2/Coordinates/'));
  
R=zeros(2,1000000);
 



    c2_ave=mean(C2,2);
 c3_ave=mean(C3,2);
ran=rand(1,1000000);   

R(1,:)= ((C2(1,:)-c2_ave(1)).^2+ (C2(2,:)-c2_ave(2)).^2).^0.5;
R(2,:)= ((C3(1,:)-c3_ave(1)).^2+ (C3(2,:)-c3_ave(2)).^2).^0.5;

 
   
   
   

   
intl=(rf-ri)/(len-1);
N_p=zeros(1,len);


Mean=zeros(1,len);
Median=zeros(1,len);
V=zeros(1,len);
sum_low=zeros(1,len);
sum_high=zeros(1,len);
for a=1:len
con= (abs(R(1,:)-ri-intl*(a-1))<0.05)&(ran<ran_limit(a));
N_p(a)=sum(con);
id_p=id2(con,1);
Ri=R(1,con);
R_np=zeros(1, N_p(a));

   for ii=1:N_p(a)
      
      
       index=id_p(ii);
       con2=id3(:,1)==index;
       R_np(ii)=R(2,con2);
   end
R_fi=R_np-Ri;
  histogram( R_fi); 
   
   
 filename=['hist_r=' num2str(ri+intl*(a-1)) '_N=' num2str(N_p(a)) '.png' ];
 saveas(gcf, filename);
 clf

sum_low(a)=sum(R_fi<-0.2);
sum_high(a)=sum(R_fi>0.2);


Mean(a)=mean(R_fi);
Median(a)=median(R_fi);
V(a)=var(R_fi);

disp(a)

end
xx=ri:intl:rf;

clf


ax1= subplot(2,3,1);
ax2= subplot(2,3,2);
ax3= subplot(2,3,3);
ax4= subplot(2,3,4);
ax5= subplot(2,3,5);
ax6= subplot(2,3,6);



plot(ax1,xx,Mean);
plot(ax2,xx,Median);
plot(ax3,xx,V);
plot(ax4,xx,sum_high./sum_low);
plot(ax5,xx,sum_low);
plot(ax6,xx,N_p);
title(ax1,'Mean');
title(ax2,'Median');
title(ax3,'Variance');
title(ax4,'outwards/inwards');
title(ax5,'N_inwards');
title(ax6,'N_p');
la3='R_change_Feb_10B.png';
saveas(gcf,la3);
fname=['Feb_Change' num2str(ni) '_to_' num2str(nf) '.mat'];
save(fname);
end