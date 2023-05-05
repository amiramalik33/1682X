close all
clear all

%% Changeable
DATA = readtable("AABV_flight1.csv");
Name = 'First Flight';
xlow = 7000;
xhigh = 43300;

%% Overview Plot
overview=tiledlayout(5,1, "TileSpacing","tight", "Padding", "tight");

nexttile;
title(Name)
subtitle("MPPT & Battery Current")
hold on
yyaxis left
ylabel("MPPT Current, A")
plot(DATA.Time, DATA.MPPT_Current, 'b');
yyaxis right
ylabel("Battery Current, A")
plot(DATA.Time, DATA.Battery_Current, 'r');

nexttile;
subtitle("Speeds")
hold on
yyaxis left
ylabel("Airspeed, m/s")
plot(DATA.Time, DATA.Indicated_Airspeed);
ylim([0, 30])
yyaxis right
ylabel("Ground Speed, m/s")
plot(DATA.Time, DATA.Ground_Speed);
ylim([0, 30])

nexttile;
subtitle("Altitude")
hold on
ylabel("m")
plot(DATA.Time, DATA.GPS_Altitude/1000)
ylim([0, 45])

nexttile;
subtitle("Angular Rates")
hold on
ylabel("radians")
plot(DATA.Time, DATA.X_Angular_Rate)
plot(DATA.Time, DATA.Y_Angular_Rate)
plot(DATA.Time, DATA.Z_Angular_Rate)
legend('X', 'Y', 'Z');

nexttile;
subtitle("Radio Commands")
hold on
ylabel("PWM Signal")
plot(DATA.Time, DATA.Left_Motor)
plot(DATA.Time, DATA.Right_Motor)
plot(DATA.Time, DATA.Left_Aileron)
plot(DATA.Time, DATA.Right_Aileron)
plot(DATA.Time, DATA.Elevator)
plot(DATA.Time, DATA.Rudder)
legend('LMotor', 'RMotor', 'LAil', 'RAil', 'Ele', 'Rud')

xlabel("time, centiseconds from start")
linkaxes(overview.Children,'x')
xlim([xlow, xhigh])