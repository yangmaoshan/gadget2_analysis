a=(a_plus_c+a_minus_c)/2;

e= (a_plus_c-a_minus_c)./(2*a);
a_=(a_plus_c_+a_minus_c_)/2;

e_=(a_plus_c_-a_minus_c_)./(2*a_);



clf
ax1= subplot(1,2,1);
ax2= subplot(1,2,2);
scatter(ax1,a, e, 10);
scatter(ax2,a_, e_   ,10);


xlabel(ax1, 'a (kpc) ');
ylabel(ax1, 'e');

xlabel(ax2, ' a (kpc)');
ylabel(ax2, '  e');
%scatter(ax1,abs(jump_total), dist_total)
%histogram(ax2,abs(jump_total))
