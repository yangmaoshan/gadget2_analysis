OCC=zeros(1,N_p);
IND=zeros(100,N_p);

OCC_r=zeros(1,N_p);
IND_r=zeros(100,N_p);
N_scatter=0;
for k=1:N_p
    r=R(:,k);
    [p, loc]=findpeaks(r);
    [p2, loc2]=findpeaks(-r);
    lo=[loc;loc2];
    [occ,ind]=find_scatter_v4(p, -p2, loc,loc2);
    OCC(k)=occ;
    IND(:,k)=ind;
    % ind_check=(ind > (jjk-ij)-5)& (ind < (jjk-ij)+5);
    if (occ>0) 
        kkk=0;
    for kk=1:occ
        low=max(1,ind(kk)-5);
        high=min(100,ind(kk)+5);
        con_d=(Dist(low:high,k)<dist_limit);
        
        if sum(con_d)>0.5
            kkk=kkk+1;
            IND_r(kkk,k)=ind(kk);
        end
        
        
    end
    
    OCC_r(k)=kkk;
    
    
        disp(k)
        N_scatter=N_scatter+1;
    end
    
    

end
ratio_occ=sum(OCC)/N_p;
ratio_occ_r=sum(OCC_r)/N_p;

ratio=N_scatter/N_p;