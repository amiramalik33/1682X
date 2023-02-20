clear all
close all

V = 9; %approximate planing speed
l = 0:.1:10;

alpha = 4*pi/180;
RE = V*l*(1.053*10^6);

CDA = (1.0668^2*pi*alpha^2)/4 + .88*alpha^3*l + 1.328*l./(RE.^.5);

h1 = figure(1);
plot(l, CDA)
hold on
title("CDA vs Length at V = " + V)
xlabel("Length, m")
ylabel("CDA")