clf

R=((x-x_ori).^2+ (y-y_ori).^2).^0.5;
for ji=1:30
    
  %  if OCC(ji)>0
disp(ji)
ax1= subplot(1,2,1);
ax2= subplot(1,2,2);
c = linspace(1,10,step);
scatter(ax1,x(:,ji),y(:,ji),[],c);
plot(ax2,1:step,R(:,ji));


axis(ax2,[0 step 0 10]);

axis(ax1,'equal');axis(ax1,[-10 10 -10 10]);



fname2=['Run_77_Feb_3_partial_path' '_id_' num2str(ji) '.png'];
saveas(gcf,fname2);

clf
  %  end
end