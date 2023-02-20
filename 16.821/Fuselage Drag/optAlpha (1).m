% Alberto Pena
% Jax Rivers

clc
clear


l0 = 3.048;
alpha = pi./90;


%% Effects of Changes Frmin

b = 1.0668;
i = 1;
a_vals = [];
l_vals = [];
v_vals= [];
cda_vals = [];
l_tot = [];

for Frmin = 1:0.01:3
    [a_vals(i), l_vals(i), v_vals(i), cda_vals(i)] = alphaOpt(Frmin,b,alpha,l0);
    l_tot(i) = l_vals(i).*(Frmin.^2);
    %l_vals(i) = Frmin.^2 .* l_val;
    i = i + 1;
end

figure(1)
Frmin = 1:0.01:3;
%plot(Frmin, v_vals,'-b','LineWidth',2)
hold on
subplot(2,1,1)
plot(Frmin, v_vals,'-b','LineWidth',2);
xlabel('Froude Number')
ylabel('Planing Velocity [m/s]')

subplot(2,1,2)
plot(Frmin, cda_vals,'-b','LineWidth',2);
xlabel('Froude Number')
ylabel('Minimum CDA [m^2]')
%ylabel('CDA at beginning of planing [m^2]')
hold off

figure(2)
hold on
subplot(2,1,1)
plot(Frmin, l_vals,'-b','LineWidth',2);
xlabel('Froude Number')
ylabel('Planing Length [m]')

subplot(2,1,2)
plot(Frmin, l_tot,'-b','LineWidth',2);
xlabel('Froude Number')
ylabel('Total Length [m]')
hold off

%% Effects of changing beam

Frmin = 1.5;
i = 1;
a_vals = [];
l_vals = [];
v_vals= [];
cda_vals = [];

for beam = 1:0.01:2
    [a_vals(i), l_vals(i), v_vals(i), cda_vals(i)] = alphaOpt(Frmin,beam,alpha,l0);
    i = i + 1;
end

figure(3)
beam = 1:0.01:2;
hold on

subplot(3,1,1)
plot(beam, v_vals,'-b','LineWidth',2);
xlabel('Beam [m]')
ylabel('Planing Velocity [m/s]')

subplot(3,1,2)
plot(beam, l_vals.*(Frmin.^2),'-b','LineWidth',2);
xlabel('Beam [m]')
ylabel('Total Length [m]')

subplot(3,1,3)
plot(beam, cda_vals,'-b','LineWidth',2);
xlabel('Beam [m]')
ylabel('Minimum CDA [m^2]')
%ylabel('CDA at beginning of planing [m^2]')
hold off
