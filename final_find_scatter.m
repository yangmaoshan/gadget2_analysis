pw='C:\Users\jianwu\Desktop\gadget_matlab';
addpath(pw);

r65=[pw '\Run\Run75_1G_11_15_small'];
disp(r65)
cd(r65)

[N_p,N_scatter,ratio]=calculate_scatter(6, 1, 5, 0.001);

disp(N_scatter)

r65=[pw '\Run\Run77_1G_11_15_small'];
disp(r65)
cd(r65)

[N_p2,N_scatter2,ratio2]=calculate_scatter(6, 1, 5, 0.001);

disp(N_scatter2)