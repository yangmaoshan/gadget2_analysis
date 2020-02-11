clf
ax1= subplot(1,3,1);
ax2= subplot(1,3,2);
ax3=subplot(1,3,3);
s1 = scatter(ax1,a, e, 5);
s2 = scatter(ax2,a_, e_,5);
s2.MarkerEdgeAlpha = 0.5;
s1.MarkerEdgeAlpha = 0.5;
ax1.FontSize =25;
ax1.Box = 'on';
ax1.YTick = [.2 .4 .6 .8 1];
xlabel(ax1, 'Semi-major axis (kpc)');
ylabel(ax1, 'Eccentricity');
t = text(ax1, 10, 0.7, 'T = 0');
t.FontSize = 25;
xlabel(ax2, 'Semi-major axis (kpc)');
ylabel(ax2, 'Eccentricity');
ax2.FontSize =25;
ax2.Box = 'on';
t = text(ax2, 10, 0.7, 'T = 15');
t.FontSize = 25;
ax2.YTick = [.2 .4 .6 .8 1];
axis(ax1,[0 16 0 1]);
axis(ax2,[0 16 0 1]);
N_int = 28;
ave_a= zeros(1,N_int);
ave_a_= zeros(1,N_int);
for kk = 1:N_int
    
    sel =(( a> (kk-1)*0.5) & ( a< (kk)*0.5));
    sel_=(( a_> (kk-1)*0.5) & ( a_< (kk)*0.5));
    ave_a(kk) =  mean(e(sel));
    ave_a_(kk) =  mean(e_(sel_));
end

x_ave = (1:28)*0.5 -0.25;

hold(ax1,'on')

pp1=plot(ax1, x_ave, ave_a,'r');
hold(ax2,'on')
pp2=plot(ax2, x_ave, ave_a_,'k');
plot(ax3, x_ave, ave_a,'r');
hold(ax3,'on')
plot(ax3, x_ave, ave_a_,'k');
xlabel(ax3, 'Semi-major axis (kpc)');
ylabel(ax3, 'Eccentricity');
legend(ax3,{'Azimuthal average at T = 0','Azimuthal average at T = 15'}, 'FontSize',20);
legend(ax1,pp1,{'Azimuthal average'}, 'FontSize',20);
legend(ax2,pp2, {'Azimuthal average'}, 'FontSize',20);
ax3.FontSize =25;
ax3.YTick = [.2 .4 .6];