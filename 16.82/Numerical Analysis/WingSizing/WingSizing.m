close all
clear all

%% User Inputs
% *most sensitive parameters are: cl, D, eta_prop, eta_motor, irradiance

%Knobs
cl  = .7;
cd_wing = .017;
rho = 0.91; %just under 3000' density altitude
L  = 226*9.8;
D_airframe  = 40; %from drag build up, N
e  = .8; %WAG: post-results, must make wing that meets this e in XFLR5

%% Analysis Setup
%Aero Relationships (fixed lift analysis)

%Power Assumptions [worst, best]
eta_prop        = [.85, .85]; %.765 real
eta_motor       = [.9622, .9622];
eta_cells       = [.225, .225];
panel_area_eff  = [.75, .85];
eta             = eta_prop.*eta_motor;
eta_panel       = eta_cells.*panel_area_eff;
irrad           = 800; %W/m^2

%Sweep Through speeds, upon which W/S & T/W are parametrized
V  = 18:-1:10;
WS = 25:5:600;

S = []; S2 = []; P_best = []; P_worst = []; P_med = []; W_w = []; PG = []; PR = [];

%% T/W vs W/S Plots and Power Analysis
h1 = figure(1);
for i = 1:length(V)
    hold on
    Snow = 2*L/cl/rho/(V(i)^2);
    D = .5*cd_wing*rho*Snow*(V(i)^2) + D_airframe;
    cd = 2*D/rho/Snow/(V(i)^2);
    AR = get_AR(L/D);
    k  = 1/(3.14159*AR*e);
    cdi = k*cl^2;

    TW = TW_fixedV(WS, cd, rho, V(i), k);
    plot(WS, TW, 'DisplayName', sprintf('%d knots', fix(V(i)*1.994)))
    [TWmin, b] = min(TW);
    WSmin = WS(b);

    [u, v, w, pg, pr] = PowerEta(Snow, eta, eta_panel, rho, cd, cl, WSmin, irrad);

    S = [S Snow];
%     P_worst = [P_worst v];
%     P_best  = [P_best u];
    P_med   = [P_med w];
    PG      = [PG, pg];
    PR      = [PR, pr];

%     mass = WingWeight(Snow, AR);
%     W_w = [W_w mass];

end
xlabel('W/S, Pa');
ylabel('T/W');
legend
title('T/W and W/S for a given V')


%% Power/Speed Plots

% h2 = figure(2);
% title('Worst Efficiency Case')
% yyaxis left
% plot(S, V*1.994)
% ylabel('Speed, knots')
% grid on
% hold on
% 
% yyaxis right
% plot(S, P_worst)
% xlabel('Wing Area, m^2')
% ylabel('Power, Generated/Required')

% h3 = figure(3);
% title('Best Efficiency Case')
% yyaxis left
% plot(S, V*1.994)
% ylabel('Speed, knots')
% grid on
% hold on
% 
% yyaxis right
% plot(S, P_best)
% xlabel('Wing Area, m^2')
% ylabel('Power, Generated/Required')

h4 = figure(4);
title("Avg Efficiency Case")
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
hold off

h6 = figure(6);
title("Avg Efficiency Case")
yyaxis left
plot(S, PG)
ylabel('Power Generated')
ylim([0 4000])
grid on
hold on

yyaxis right
plot(S, PR)
xlabel('Wing Area, m^2')
ylabel('Power Required')
ylim([0 4000])
yline(1)
hold off

% h5 = figure(5);
% plot(S, W_w*2.205) %in pounds
% xlabel('Wing Area, m^2')
% ylabel('Wing Weight, lbs')
% title('Wing Mass')