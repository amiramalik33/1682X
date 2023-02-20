length = linspace(1,25);
V_h = .35;
V_v = .03;
S_h = V_h*S*c./length;
S_v = V_v*S*b./length;
htail_AR = 4.6;
vtail_AR = 1.1;
%Horizontal Tail Weight
g1 = figure(1);
htail_mass = TailWeight(S_h,htail_AR);
plot(length,htail_mass);
title('Horizontal Tail Mass Depending on Length of Boom');
xlabel('Length [m]');
ylabel('Horizontal Tail Mass [kg]');
g2 = figure(2);
plot(length,S_h);
title('Horizontal Tail Area Depending on Length of Boom');
xlabel('Length [m]');
ylabel('Horizontal Tail Area [m^2]');
%Vertical Tail Weight
g3 = figure(3);
vtail_mass = TailWeight(S_v,vtail_AR);
plot(length,vtail_mass);
title('Vertical Tail Mass Depending on Length of Boom');
xlabel('Length [m]');
ylabel('Vertical Tail Mass [kg]');
g4 = figure(4);
plot(length,S_v);
title('Vertical Tail Area Depending on Length of Boom');
xlabel('Length [m]');
ylabel('Vertical Tail Area [m^2]');
%Rod Weight
g5 = figure(5);
r_mass = .2.*length;
plot(length,r_mass);
title('Boom Mass Depending on Length');
xlabel('Length [m]');
ylabel('Boom Mass [kg]');
%Total Weight
g6 = figure(6);
mass_total = htail_mass + vtail_mass + r_mass;
plot(length, mass_total);
title('Total Mass of Boom and Tails Depending on Length');
xlabel('Length [m]');
ylabel('Total Mass [kg]');
pks = findpeaks(mass_total);

%Horizontal Tail is ahead of vertical tail, only elevator overlaps
length_opt_vtail = 10;
length_opt_htail = 9.6925;

%Horizontal and Vertical Tail Sizes
Sh_opt = V_h*S*c./length_opt_htail;
Sv_opt = V_v*S*b./length_opt_vtail;
htail_span = sqrt(Sh_opt*htail_AR);
vtail_span = sqrt(Sv_opt*vtail_AR);
htail_MAC = htail_span/htail_AR;
vtail_MAC = vtail_span/vtail_AR;
htail_weight = TailWeight(Sh_opt,htail_AR);
vtail_weight = TailWeight(Sv_opt,vtail_AR);
rod_weight = .2*length_opt_vtail;

mass_opt = htail_weight + vtail_weight + rod_weight;

% %Bending Case (Strength and Stress Considerations)
% E = 2.28e11;
% I = 6.937e-7;
% %Maximum Deflection
% u_l = -1*(mass_opt)*9.8*length_opt^3/(3*E*I);
% %Natural Frequency, Compared to 3 Hz for typical pilot
% w_nf = 1.875^2*sqrt(E*I/(.2*length_opt^4));
% %Stress Max vs. 3.5 GPa for Carbon Fiber
% stress_max = mass_opt*9.8*length_opt*.0254/I;
% %Critical Load of a Beam
% P_crit = pi^2*E*I/(4*length_opt^2);
% load = mass_opt*9.8;