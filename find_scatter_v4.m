% Changed the way the scattering events are filtered. 



% In v4, the length of a arm is compared with the length at previous extremum
% Then the change in length bewteen two successive extrema is valued against 
% 0.2 * the average arm length.




function [occurance, index]=find_scatter_v4(pkh,pkl,lnh,lnl)
    pg=0.2;
     index=zeros(100,1);
     
     if (length(pkh)<3) && (length(pkl)<3)
         occurance=0;
         return
     end
     
         
         
  if lnh(1)>lnl(1)
    
      if length(lnh)== length(lnl)
          
          
          
          
          
          diff=pkh-pkl;
          len=length(lnl);
          lnh_=lnh(2:(len-1));
          lnl_=lnl(2:len);
          
          diff2=pkh(1:(len-1))-pkl(2:len);
          diffh=diff(1:(len-1))+diff2;
          diffl=diff(2:len)+diff2;
      dif=[diffh; diffl];
     d_mode=median(dif);
      d_var=(var(dif))^0.5;
         ld= diffl-diffh;
         hd= diffh(2:(len-1))-diffl(1:(len-2));  
           
     con= (abs(hd) >pg*d_mode );
      conl=(abs(ld) >pg*d_mode  );
      index_temp=[lnh_(con);lnl_(conl)];
      
     
      occurance=length(index_temp);
      index(1:occurance)=index_temp;
      else
          len=length(lnl);
          lnh_=lnh(2:(len-1));
          lnl_=lnl(2:(len-1));
          
          
          diff=pkh-pkl(1:(len-1));
          
          diff2=pkh-pkl(2:len);
          diffh=diff+diff2;
           diffl=diff(2:(len-1))+diff2(1:(len-2));
            dif=[diffh; diffl];
       d_mode=median(dif);
      d_var=(var(dif))^0.5;
           ld= diffl-diffh(1:(len-2));
         hd= diffh(2:(len-1))-diffl(1:(len-2));  
           
       con= (abs(hd) >pg*d_mode );
      conl=(abs(ld) >pg*d_mode  );
      
      index_temp=[lnh_(con);lnl_(conl)];
      
     
      occurance=length(index_temp);
      index(1:occurance)=index_temp;
      end
      
  else 
      
      
       if length(lnh)== length(lnl)
          
          
          
          
          
          diff=pkh-pkl;
          len=length(lnl);
          lnl_=lnl(2:(len-1));
          lnh_=lnh(2:len);
          
          diff2=pkh(2:len)-pkl(1:(len-1));
          diffl=diff(1:(len-1))+diff2;
          diffh=diff(2:len)+diff2;
      dif=[diffh; diffl];
       d_mode=median(dif);
      d_var=(var(dif))^0.5;
           hd= diffh-diffl;
         ld= diffl(2:(len-1))-diffh(1:(len-2));  
           
     con= (abs(hd) >pg*d_mode );
      conl=(abs(ld) >pg*d_mode  );
      
      index_temp=[lnh_(con);lnl_(conl)];
      
     
      occurance=length(index_temp);
      index(1:occurance)=index_temp;
      
      else
          len=length(lnh);
          lnl_=lnl(2:(len-1));
          lnh_=lnh(2:(len-1));
          
          
          diff=pkh(1:(len-1))-pkl;
          
          diff2=pkh(2:len)-pkl;
          diffl=diff+diff2;
           diffh=diff(2:(len-1))+diff2(1:(len-2));
            dif=[diffh; diffl];
      d_mode=median(dif);
 d_var=(var(dif))^0.5;
           hd= diffh-diffl(1:(len-2));
         ld= diffl(2:(len-1))-diffh(1:(len-2));  
           
      con= (abs(hd) >pg*d_mode );
      conl=(abs(ld) >pg*d_mode  );
      
      
      index_temp=[lnh_(con);lnl_(conl)];
      
     
      occurance=length(index_temp);
      index(1:occurance)=index_temp;
      end
      
      
  end
  

  
    


end