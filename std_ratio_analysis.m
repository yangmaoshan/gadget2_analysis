

Dist=zeros(step,N_p);
for k=1:N_p
    
        for kk=1:step
            t=kk;
            
            dist=((xg(t,:)-x(t,k)).^2+(yg(t,:)-y(t,k)).^2+(zg(t,:)-z(t,k)).^2).^0.5;
            
            Dist(kk,k)=min(dist);
            
        end
     
end


Dist_MIN=zeros(step,N_p);

R=((x-c2_ave(1)).^2+ (y-c2_ave(2)).^2).^0.5;
OCC=zeros(1,N_p);
IND=zeros(step,N_p);

JUMP=zeros(step,N_p);

OCC_r=zeros(1,N_p);
IND_r=zeros(step,N_p);
N_scatter=0;
for k=1:N_p
    r=R(:,k);
    [p, loc]=findpeaks(r);
    [p2, loc2]=findpeaks(-r);
    lo=[loc;loc2];
    [occ,ind, jump]=find_scatter_v6(p, -p2, loc,loc2,step);
    OCC(k)=occ;
    IND(:,k)=ind;
    JUMP(:,k)=jump;
    % ind_check=(ind > (jjk-ij)-5)& (ind < (jjk-ij)+5);
    if (occ>0) 
        kkk=0;
    for kk=1:occ
        low=max(1,ind(kk)-affected_tstep);
        high=min(step,ind(kk)+affected_tstep);
        dist_min=min(Dist(low:high,k));
        Dist_MIN(kk,k)=dist_min;
        if dist_min < dist_limit
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



N_event=sum(OCC);
jump_total=zeros(N_event,1);
k1=1; k2=1;
for k=1:N_p
    if OCC(k)>0
        k2=k2+OCC(k)-1;
   jump_total(k1:k2)=JUMP(1:OCC(k),k);
   k1=k2+1;
   k2=k1;
    end
    
    
end


dist_total=zeros(N_event,1);
k1=1; k2=1;
for k=1:N_p
    if OCC(k)>0
        k2=k2+OCC(k)-1;
   dist_total(k1:k2)=Dist_MIN(1:OCC(k),k);
   k1=k2+1;
   k2=k1;
    end
    
    
end

Dist_col=min(Dist);

DD= reshape(Dist,[N_p*step,1]);

