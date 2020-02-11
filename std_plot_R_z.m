
clf


 %cond = ((a<i*0.5)&(a>(i*0.5-0.5)));
    
    %scatter(ax1, a_(cond)-a(cond), e_(cond) -e(cond));
    
ax1= subplot(1,2,1);
ax2= subplot(1,2,2);
scatter(ax1,R(1,:), z(1,:), 10);
scatter(ax2,R(375,:), z(375,:) ,10);


xlabel(ax1, 'r (kpc) ');
ylabel(ax1, ' z');

xlabel(ax2, ' r (kpc)');
ylabel(ax2, ' z');



saveas(gcf, 'R_vs_z_375.png')