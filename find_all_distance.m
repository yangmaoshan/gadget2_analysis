

Dist=zeros(100,N_p);
for k=1:N_p
    
    
       
        
        for kk=1:100
            t=kk;
            
            dist=((xg(t,:)-x(t,k)).^2+(yg(t,:)-y(t,k)).^2+(zg(t,:)-z(t,k)).^2).^0.5;
            
            Dist(kk,k)=min(dist);
            
        end
        
        
        
    
    

end