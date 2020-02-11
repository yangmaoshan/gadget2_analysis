
clear
ij=25; dds=1; ddl=10; ran_limit=0.001; n_gas=20; dist_limit=0.3;

pw='C:\Users\jianwu\Desktop\gadget_matlab';
addpath(pw);



r65=[pw '\Run\Run65_3G_12_17'];
disp(r65)
cd(r65)


Jump(ij,dds,ddl,ran_limit,n_gas, dist_limit);
clear



ij=25; dds=1; ddl=10; ran_limit=0.001; n_gas=200; dist_limit=0.3;

pw='C:\Users\jianwu\Desktop\gadget_matlab';
addpath(pw);

r65=[pw '\Run\Run73_3G_12_17'];
disp(r65)
cd(r65)


Jump(ij,dds,ddl,ran_limit,n_gas, dist_limit);
clear



ij=6; dds=1; ddl=5; ran_limit=0.001; n_gas=20; dist_limit=0.3;

pw='C:\Users\jianwu\Desktop\gadget_matlab';
addpath(pw);


r75=[pw '\Run\Run75_1G_11_15_small'];
disp(r75)
cd(r75)


Jump(ij,dds,ddl,ran_limit,n_gas, dist_limit);
clear




ij=6; dds=1; ddl=5; ran_limit=0.001; n_gas=200; dist_limit=0.3;

pw='C:\Users\jianwu\Desktop\gadget_matlab';
addpath(pw);


r75=[pw '\Run\Run77_1G_11_15_small'];
disp(r75)
cd(r75)


Jump(ij,dds,ddl,ran_limit,n_gas, dist_limit);

