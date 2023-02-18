close all
clear all

%Good Assumptions
cl  = 1.2;
rho = 0.91;

%Drag Build-Up Assumptions
LD = 22;
L  = 226*9.8;
D  = L/LD;

%Power Assumptions
eta_prop        = [.765, .765];
eta_motor       = [.9622, .9622];
eta_cells       = [.224, .224];
panel_area_eff  = [.75, .85];
eta             = eta_prop.*eta_motor;
eta_panel       = eta_cells.*panel_area_eff;
irrad           = 800; %W/m^2

%WAGS
e  = .8;
AR = 15;
k  = 1/(3.14159*AR*e);

%Sweep Through speeds, upon which W/S & T/W are parametrized
V  = 10:1:18;
WS = 25:5:600;

S = []; S2 = []; P_best = []; P_worst = []; P_med = []; W_w = [];

h1 = figure(1);
for i = 1:length(V)
    hold on
    Snow = 2*L/cl/rho/(V(i)^2);
    cd = 2*D/rho/Snow/(V(i)^2);

    TW = TW_fixedV(WS, cd, rho, V(i), k);
    plot(WS, TW, 'DisplayName', sprintf('%d knots', fix(V(i)*1.994)))
    [TWmin, b] = min(TW);
    WSmin = WS(b);

    [u, v, w] = PowerEta(Snow, eta, eta_panel, rho, cd, cl, WSmin, irrad);

    S = [S Snow];
    P_worst = [P_worst v];
    P_best  = [P_best u];
    P_med   = [P_med w];

    mass = WingWeight(Snow, AR);
    W_w = [W_w mass];

%     Snow2 = L/WSmin;
%     S2 = [S2 Snow2];

end
xlabel('W/S, Pa');
ylabel('T/W');
legend
title('T/W and W/S for a given V')

h2 = figure(2);
title('Worst Efficiency Case')
yyaxis left
plot(S, V*1.994)
ylabel('Speed, knots')
grid on
hold on

yyaxis right
plot(S, P_worst)
xlabel('Wing Area, m^2')
ylabel('Power, Generated/Required')

h3 = figure(3);
title('Best Efficiency Case')
yyaxis left
plot(S, V*1.994)
ylabel('Speed, knots')
grid on
hold on

yyaxis right
plot(S, P_best)
xlabel('Wing Area, m^2')
ylabel('Power, Generated/Required')

h4 = figure(4);
title('Avg Efficiency Case')
yyaxis left
plot(S, V*1.994)
ylabel('Speed, knots')
grid on
hold on

yyaxis right
plot(S, P_med)
xlabel('Wing Area, m^2')
ylabel('Power, Generated/Required')
yline(1)

h5 = figure(5);
plot(S, W_w*2.205) %in pounds
xlabel('Wing Area, m^2')
ylabel('Wing Weight, lbs')
title('Wing Mass')