M_sun= 1.989*10^30;
len_unit= 3.086*10^19;
M_unit=M_sun*10^10* 3.39*10^(-6);
G= 6.674*10^(-11);

des_sigma = des*M_unit/(len_unit^2);
omega = rotat * 1000 ./(rotatx * len_unit);

Q = vdisp_r * (1000) *2 /3.36 /G .*omega ./des_sigma;

plot(rotatx(1:(N/4)),Q(1:(N/4)));


