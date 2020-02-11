function [occurance, index]=find_scatter(v)
    

    

    len=length(v);
    sep=v(2:len)-v(1:(len-1));
    separ=mode(sep);
    index=zeros(100,1);
    occurance=0;
    for kk=2:(len-1)
        if (abs(v(kk)-v(kk-1)-separ)>1)||(abs(v(kk+1)-v(kk)-separ)>1)
            occurance=occurance+1;
            index(occurance)=v(kk);
            
            
        end
            
            
    end
    


end