function xyhr= newcoor1(unitx,unity,unitz,p,ori)

t=transpose(p-ori);

x=dot(unitx,t );
y=dot(unity,t );
h=dot(unitz,t );
r=(x^2+y^2)^0.5;
xyhr=[x;y;h;r];
end