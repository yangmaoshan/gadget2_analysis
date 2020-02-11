R=((x-c2_ave(1)).^2+ (y-c2_ave(2)).^2).^0.5;
OCC=zeros(1,N_p);
IND=zeros(100,N_p);
N_scatter=0;
 k=3;
    r=transpose([1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2]);
    [p, loc]=findpeaks(r);
    [p2, loc2]=findpeaks(-r);
    lo=[loc;loc2];
    [occ,ind]=find_scatter_v2(p, -p2, loc,loc2);
    OCC(k)=occ;
    IND(:,k)=ind;
     ind_check=(ind > (jjk-ij)-5)& (ind < (jjk-ij)+5);
    
    if (occ>0) && (sum(ind_check)>0.5)
        disp(k)
        N_scatter=N_scatter+1;
    end
    
    



% ratio=N_scatter/N_p;