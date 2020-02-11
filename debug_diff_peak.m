

N_strange=0;N_strange2=0;
sum=0;sum2=0;
for k=1:N_p
    r=R(:,k);
    [p, loc]=findpeaks(r);
    [p2, loc2]=findpeaks(-r);
    lp=length(p);
    
    diff_p=p(2:lp)-p(1:(lp-1));
     mean_diff=mean(abs(diff_p));
    if isnan(mean_diff)
        disp('hahaha found you')
        disp(k)
        mean_diff=0;
        N_strange=N_strange+1;
   
    end
    
    sum=sum+ mean_diff;
  
    
    
    lp2=length(p2);
    
    diff_p2=p2(2:lp2)-p2(1:(lp2-1));
     mean_diff2=mean(abs(diff_p2));
    if isnan(mean_diff2)
        disp('hahaha found you 2')
        disp(k)
        mean_diff2=0;
        N_strange2=N_strange2+1;
  
    end
    
    
   
    sum2=sum2+ mean_diff2;
    
%     if isnan(sum2)
%         disp('sum2      sum2     sum2       sum2     sum2       sum2')
%         disp(k)
%        
%     end

end

sum_t=sum/(N_p-N_strange);
sum_t2=sum2/(N_p-N_strange2);
