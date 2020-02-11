pwd='C:\Users\jianwu\Desktop\gadget_matlab';
addpath(pwd);

r65=[pwd '\Run\Run75_8_22'];
disp(r65)
cd(r65)

n=70;

Mean_=zeros(n,7);

ave_Dispe_=zeros(1,n);
delta_R_over_R_=zeros(1,n);
kk_=zeros(1,n);
change_plus_=zeros(1,n);
change_minus_=zeros(1,n);
n_plus_=zeros(1,n);
n_minus_=zeros(1,n);

c_plus_=zeros(1,n);
c_minus_=zeros(1,n);
med1_=zeros(1,n);
med2_=zeros(1,n);
ind=15:40;

for i=1:35
[Mean_(i,:), ave_Dispe_(i), delta_R_over_R_(i), kk_(i), change_plus_(i), change_minus_(i), n_plus_(i), n_minus_(i), c_plus_(i), c_minus_(i), med1_(i), med2_(i)]=fplot_R_change_v10_25(i+4,i+5,1,7,7,75);


end



cd([pwd '\Run\Run77_8_29'])
disp([pwd '\Run\Run77_8_29'])

for i=36:70
[Mean_(i,:), ave_Dispe_(i), delta_R_over_R_(i), kk_(i), change_plus_(i), change_minus_(i), n_plus_(i), n_minus_(i), c_plus_(i), c_minus_(i), med1_(i), med2_(i)]=fplot_R_change_v10_25(i-31,i-30,1,7,7,77);


end
