clf


for ji=1:N_p
    
  %  if OCC(ji)>0
disp(ji)
ax1= subplot(1,2,1);
ax2= subplot(1,2,2);
c = linspace(1,10,100);
scatter(ax1,x(:,ji),y(:,ji),[],c);
plot(ax2,1:100,R(:,ji));


axis(ax2,[0 100 0 8]);

axis(ax1,'equal');axis(ax1,[-6 6 -6 6]);

hold(ax1,'on')

scatter(ax1,x0,y0,'filled')

hold(ax1,'off')

fname2=['Run_75_special_Dec_6_x0_'  num2str(x_p(ji))  '_y0_' num2str(y_p(ji)) '_id_' num2str(ji) '_path.png'];
saveas(gcf,fname2);

clf
  %  end
end