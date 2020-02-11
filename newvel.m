function tr= newvel(cc,vv)

c=[cc(1); cc(2)];
v=[vv(1); vv(2)];
unitr=c/norm(c);
unitt=[-unitr(2);unitr(1)];

t=dot(unitt,v );
r=dot(unitr,v );

tr=[t;r];
end