function ori = height(cc,p)
A=[cc(1) cc(2) -1;1/cc(1) 0 1; 0 1/cc(2) 1];
B=[-cc(3); p(3)+p(1)/cc(1) ;  p(3)+p(2)/cc(2)];
ori=A\B;


end