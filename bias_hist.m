clf

R=((x-x_ori).^2+ (y-y_ori).^2).^0.5;

a1=0.1;
a2=0.5;
a3=1;
sum1_low=sum(R<(dds-a1),2);
sum1_high=sum(R>(ddl+a1),2);
sum2_low=sum(R<(dds-a2),2);
sum2_high=sum(R>(ddl+a2),2);
sum3_low=sum(R<(dds-a3),2);
sum3_high=sum(R>(ddl+a3),2);

sum_21_low=sum1_low-sum2_low;
sum_21_high=sum1_high-sum2_high;
sum_32_low=sum2_low-sum3_low;
sum_32_high=sum2_high-sum3_high;
for ji=1:step
    
  %  if OCC(ji)>0
disp(ji)
ax1= subplot(1,2,1);
ax2= subplot(1,2,2);
%c = linspace(1,10,step);
scatter(ax1,x(ji,:),y(ji,:),3,'filled');
%plot(ax2,1:step,R(:,ji));
histogram(ax2, R(ji,:));

%axis(ax2,[0 step 0 8]);

axis(ax1,'equal');axis(ax1,[-10 10 -10 10]);



fname2=['Run_77_Feb_10_bias_5p5_time_'  num2str(ij+ji*5) '_distribution.png'];
saveas(gcf,fname2);

clf
  %  end
end