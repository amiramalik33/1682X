length = linspace(1,10);
V_h = .3;
V_v = .025;
S = 20.2;
c = 1.16;
b = 17.4;
%AR_htail = 4.6
%AR_vtail = 1.1
r_mass = .2.*length;
E = 2.28e11;
I = 6.937e-7;
S_h = V_h*S*c./length;
S_v = V_v*S*b./length;
htail_mass = TailWeight(S_h,4.6);
vtail_mass = TailWeight(S_v,1.1);
total_mass = htail_mass + vtail_mass;
%u_x = -1*total_mass*length^3/(3*E*I);
%Length vs. Horizontal Tail Area
%plot(length,S_h);
%xlabel('Horizontal Tail Length');
%ylabel('Horizontal Tail Area');
%Length vs. Vertical Tail Area
plot(length,S_v);
xlabel('Vertical Tail Length');
ylabel('Vertical Tail Area');