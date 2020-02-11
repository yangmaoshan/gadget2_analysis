clf
ax1= subplot(1,1,1);

for i=1:14
    
    cond = ((a<i*0.5)&(a>(i*0.5-0.5)));
    
    scatter(ax1, a_(cond)-a(cond), e_(cond) -e(cond));
    
    saveas(gcf, ['change_104_a_vs_e_' num2str(i) '.png'])
end