jjk=105;

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
   
   R=((C2(1,:)-c2_ave(1)).^2.+(C2(2,:)-c2_ave(2)).^2).^0.5;
   
   
   N=200;
   R_m=10;
   dr=R_m/N/2;
  z_half=zeros(3,N);
for i=1:N
  con= ((R<(dr+R_m/N*i))& (R>=(-dr+R_m/N*i)));
  zz=C2(3, con);
   z_half(1,i)= median(zz(zz>0));
    z_half(2,i)= (-1)*median(zz(zz<0));
   z_half(3,i)= median(abs(C2(3, con)));
end
    
    lx=(1:N)*R_m/N;
    
    
    ax1= subplot(2,2,1);
ax2= subplot(2,2,2);
  ax3= subplot(2,2,3);
ax4= subplot(2,2,4);

scatter(ax1,R,C2(3,:),1);
plot(ax2,lx,z_half(1,:));
plot(ax3,lx,z_half(2,:));
plot(ax4,lx,z_half(3,:));