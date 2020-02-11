clf

ss=6;
for ji=1:10
    
  %  if OCC(ji)>0
disp(ji)
ax1= subplot(1,2,1);
ax2= subplot(1,2,2);
c = linspace(1,10,step);
scatter(ax1,x(:,ji),y(:,ji),[],c);
plot(ax2,1:step,R(:,ji));


axis(ax2,[0 step 0 8]);

axis(ax1,'equal');axis(ax1,[(-1)*ss ss (-1)*ss ss]);



%fname2=['Run_75_special_Jan_20_x0_'  num2str(x_p(ji))  '_y0_' num2str(y_p(ji)) '_id_' num2str(ji) '_path.png'];

fname2=['Run_104_x0_'  num2str(x_p(ji))  '_y0_' num2str(y_p(ji)) '_id_' num2str(ji) '_path.png'];
saveas(gcf,fname2);

clf
  %  end
end