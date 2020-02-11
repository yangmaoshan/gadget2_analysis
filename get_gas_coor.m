

jjk=55;
if jjk<10
  g3=['snapshot_00' num2str(jjk)  '.hdf5'];
  elseif jjk<100
      g3=['snapshot_0' num2str(jjk) '.hdf5'];
  else
      g3=['snapshot_' num2str(jjk) '.hdf5'];
  end
   
  
   id_mid =double( h5read(g3,'/PartType0/ParticleIDs/'));
   
   C3_mid= double(h5read(g3,'/PartType0/Coordinates/'));