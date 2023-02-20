% Looking at the hydrodynamics of our planing 

clear
clc

%% Drag for first half

alpha = pi./90; % trim angle
V = 8:0.01:14; % v_plan to v_to
l = linspace(3.048,0,length(V)); % planing surface length
b = 1.0668; % beam 
k_v = 1.053.*10.^-6; % kinematic velocity
Re = V.*l./k_v;
rho_water = 1000;
q_water = 0.5.*rho_water.*V.^2;
m = 256; g = 9.81;
W = m.*g;
% S = b.*l;
AR = b./l;
CL = (AR.*alpha.*pi)./4 + 0.88.*alpha.^2;
S = W./(q_water.*CL);
CDw = alpha.*CL;
CDf = 1.328./sqrt(Re);
CDA = S.*(CDw + CDf);
figure(1)
plot(V,CDA)

Drag = CDA .* q_water;

%% CDA vs Alpha

alpha_degs = 0:0.01:10;
alpha = alpha_degs .* pi./180;
V = 8;
rho_w = 1000;
q_w = 0.5.*rho_w.*V.^2;

W = m.*g;
l = 3.048;
b = 1.0668;
AR = b./l;
CL = (AR.*alpha.*pi)./4 + 0.88.*alpha.^2
Re = V.*l./k_v;
Cf = 1.328./sqrt(Re);
CDAvTrim = ((W.*alpha)./(q_w)) + ((W.*Cf)./(q_w.*CL));

figure(2)
plot(alpha_degs,CDAvTrim,'-b','LineWidth',2)
hold on
title("CDA vs Trim Angle")
ylabel("CDA [m^2]")
xlabel("Trim Angle (degrees)")
xlim([0.5 4])
hold off
