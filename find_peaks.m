
c2_ave=mean(C2,2);
R=((x-c2_ave(1)).^2+ (y-c2_ave(2)).^2).^0.5;
OCC=zeros(1,N_p);
IND=zeros(100,N_p);

for k=1:N_p
    r=R(:,k);
    [p, loc]=findpeaks(r);
    [p2, loc2]=findpeaks(-r);
    lo=[loc;loc2];
    [occ,ind]=find_scatter(sort(lo));
    OCC(k)=occ;
    IND(:,k)=ind;
    if occ>0
        disp(k)
    end
    
    

end

Dist=zeros(100,N_p);
for k=1:N_p
    
    if OCC(k)>0
       
        occ_n=OCC(k);
        for kk=1:occ_n
            t=IND(kk,k);
            
            dist=((xg(t,:)-x(t,k)).^2+(yg(t,:)-y(t,k)).^2+(zg(t,:)-z(t,k)).^2).^0.5;
            dist_hori=((xg(t,:)-x(t,k)).^2+(yg(t,:)-y(t,k)).^2).^0.5;
            
            Dist(kk,k)=min(dist_hori);
            
        end
        
        
        
    end
    
    

end