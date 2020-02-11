c3_ave=mean(C3,2);
R=((x-c3_ave(1)).^2+ (y-c3_ave(2)).^2).^0.5;
valid=zeros(1,N_p);
leng=zeros(1,N_p);
a_plus_c=zeros(1,N_p);
a_minus_c=zeros(1,N_p);
a_plus_c_=zeros(1,N_p);
a_minus_c_=zeros(1,N_p);
for k=1:N_p
    r=R(1:end,k); %51:end
    [p, loc]=findpeaks(r);
    [p2, loc2]=findpeaks(-r);
    %lo=[loc;loc2];
    p2 = -p2;
    len = length(p);
    len2 = length(p2);
    
    if len == 0 || len2 ==0
        valid(k)= -1;
    else
       
        valid(k) =1;
        leng(k)=len +len2;
        a_plus_c(k)=p(1);
        a_plus_c_(k)=p(len);
        a_minus_c(k)=p2(1);
        a_minus_c_(k)=p2(len2);
    end
    
    

end
a=(a_plus_c+a_minus_c)/2;

e= (a_plus_c-a_minus_c)./(2*a);
a_=(a_plus_c_+a_minus_c_)/2;

e_=(a_plus_c_-a_minus_c_)./(2*a_);



R0=(x_p.^2+y_p.^2).^0.5;