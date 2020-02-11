clf


ran2=rand(1,N_p);  
  
for i=1:14
    if i<11
    con3 = ((a<i*0.5)&(a>(i*0.5-0.5))&(ran2<0.02));
    ss = 6;
    else
        con3 = ((a<i*0.5)&(a>(i*0.5-0.5)));
        ss = 8 ;
    end
    x_s = x(1:step,con3);
    y_s = y(1:step,con3);
    R_s = R(1:step,con3);
    disp(i)
disp(sum(con3))
    
for ji=1:sum(con3)
    
  %  if OCC(ji)>0

ax1= subplot(1,2,1);
ax2= subplot(1,2,2);
c = linspace(1,10,step);
scatter(ax1,x_s(:,ji),y_s(:,ji),[],c);
plot(ax2,1:step,R_s(:,ji));


axis(ax2,[0 step 0 8]);

axis(ax1,'equal');axis(ax1,[(-1)*ss ss (-1)*ss ss]);



%fname2=['Run_75_special_Jan_20_x0_'  num2str(x_p(ji))  '_y0_' num2str(y_p(ji)) '_id_' num2str(ji) '_path.png'];

fname2=['Run_133_375_random_i_' num2str(i) '_id_' num2str(ji) '_path.png'];
saveas(gcf,fname2);

clf
  %  end
end
end
