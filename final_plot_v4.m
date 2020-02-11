

pwd='C:\Users\jianwu\Desktop\gadget_matlab';
addpath(pwd);

r65=[pwd '\Run\Run75_8_22'];
disp(r65)
cd(r65)

n=20;

ave_Dispe=zeros(1,n);
delta_R_over_R=zeros(1,n);
kk=zeros(1,n);
change_plus=zeros(1,n);
change_minus=zeros(1,n);
n_plus=zeros(1,n);
n_minus=zeros(1,n);

c_plus=zeros(1,n);
c_minus=zeros(1,n);
med1=zeros(1,n);
med2=zeros(1,n);
ind=6:16;

for i=1:10
[ave_Dispe(i), delta_R_over_R(i), kk(i), change_plus(i), change_minus(i), n_plus(i), n_minus(i), c_plus(i), c_minus(i), med1(i), med2(i)]=fplot_R_change_v3(i+5,i+6,0.5,7,14,75);


end



cd([pwd '\Run\Run77_8_29'])
disp([pwd '\Run\Run77_8_29'])

for i=11:20
[ave_Dispe(i), delta_R_over_R(i), kk(i), change_plus(i), change_minus(i), n_plus(i), n_minus(i), c_plus(i), c_minus(i), med1(i), med2(i)]=fplot_R_change_v3(i-5,i-4,0.5,7,14,77);


end




