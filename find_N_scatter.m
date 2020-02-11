R=((x-c2_ave(1)).^2+ (y-c2_ave(2)).^2).^0.5;
OCC=zeros(1,N_p);
IND=zeros(100,N_p);
N_scatter=0;
for k=1:N_p
    r=R(:,k);
    [p, loc]=findpeaks(r);
    [p2, loc2]=findpeaks(-r);
    lo=[loc;loc2];
    [occ,ind]=find_scatter(sort(lo));
    OCC(k)=occ;
    IND(:,k)=ind;
    %{
    if occ>0
        disp(k)
        N_scatter=N_scatter+1;
    end
    
    %}
    ind_check=(ind > 45)& (ind < 55);
    
    if (occ>0) && (sum(ind_check)>0.5)
        disp(k)
        N_scatter=N_scatter+1;
    end
    
    

end