close all
clearvars -except DATA

%% Changeable

%filename = "AABV_flight1.csv";
filename = "AABV_flight3.csv";

%% Manual File Stats

%DATA = readtable(filename);

if filename == "AABV_flight1.csv"
    Name = 'First Flight';
    xlow = 7000;
    xhigh = 40000;
    takeoff = 8700; %start takeoff run
    liftoff = 12030; %liftoff from water
    TOC = 16000;
    landing = 35160; %landing run
elseif filename == "AABV_flight3.csv"
    Name = 'Third Flight';
    xlow = 55400;
    xhigh = 86700;
    takeoff = 56400; %start takeoff run
    liftoff = 58000; %liftoff from water 
    TOC = 61200;
    landing = 84200; %landing run
end

%% Quats to Euler Angles

Euler = q2eul(DATA.Q0, DATA.Q1, DATA.Q2, DATA.Q3);

X = Euler(:,1); %roll
Y = Euler(:,2); %pitch
Z = Euler(:,3); %yaw

X = X - X(1);
Y = Y - Y(1);
Z = Z - Z(1);

%% Data Processing

ThrustPercent = (DATA.Left_Motor - 1000)/1000;
ThrustPercent = mov_avg(ThrustPercent, 25);

BatCurrent = mov_avg(DATA.Battery_Current, 100);

Airspeed = DATA.Calibrated_Airspeed*1.944; %m/s to knots
Airspeed = mov_avg(Airspeed, 25);

Gspeed = DATA.Ground_Speed*1.944; %m/s to knots
Gspeed = mov_avg(Gspeed, 25);

Altitude = DATA.Barometer_Altitude*3.281; %m to feet
Altitude = mov_avg(Altitude, 25);

Roll = X*180/pi;
Roll = mov_avg(Roll, 50);

Pitch = Y*180/pi;
Pitch = mov_avg(Pitch, 50);

%% Overview Plot
overview=tiledlayout(4,1, "TileSpacing","tight", "Padding", "tight");
set(overview,'defaultLegendAutoUpdate','off');

nexttile;
subtitle("Propulsion")
hold on
yyaxis left
plot(DATA.Time, ThrustPercent, 'b');
ylim([0,1.2]);
yticks([0 .5 1])
yyaxis right
plot(DATA.Time, BatCurrent, 'color', 'k', 'LineStyle', '--');
ylim([0,90]);
yticks([0 20 40 80])
grid on
eventlines(takeoff, liftoff, TOC, landing, true);
lgd1 = legend('Thrust Percent', 'Motor Current, A');
fontsize(lgd1,16,'points');

nexttile;
subtitle("Speeds, knots")
hold on
plot(DATA.Time, Airspeed);
ylim([0, 50])
plot(DATA.Time, Gspeed, '--');
lgd2 = legend('Airspeed', 'Ground Speed');
fontsize(lgd2,16,'points');
eventlines(takeoff, liftoff, TOC, landing, false);
yticks([0 20 40])
grid on

nexttile;
subtitle("AGL Altitude, feet")
hold on
plot(DATA.Time, Altitude)
ylim([0, 200])
eventlines(takeoff, liftoff, TOC, landing, false);
yticks([0 50 150])
grid on

nexttile;
subtitle("Attitude, Degrees")
hold on
plot(DATA.Time, Roll, 'color', 'b', 'LineStyle', '-.')
plot(DATA.Time, Pitch, 'color', 'r', 'LineStyle', '-.')
yline(0);
lgd4 = legend('Roll', 'Pitch');
fontsize(lgd4,16,'points');
eventlines(takeoff, liftoff, TOC, landing, false);
ylim([-45 45])
yticks([-40 -20 0 20 40])
grid on


xlabel("time, centiseconds from start")
linkaxes(overview.Children,'x')
xlim([xlow, xhigh])

eventlines(takeoff, liftoff, TOC, landing, false);

function eventlines(takeoff, liftoff, TOC, landing, label)
    if label
        xline(takeoff, 'r', 'Takeoff', 'LabelHorizontalAlignment', 'center', 'LabelOrientation', 'Horizontal', 'LineWidth', 2)
        xline(liftoff, 'r', 'Liftoff', 'LabelHorizontalAlignment', 'center', 'LabelOrientation', 'Horizontal', 'LineWidth', 2)
        xline(TOC, 'r', 'TOC', 'LabelHorizontalAlignment', 'center', 'LabelOrientation', 'Horizontal', 'LineWidth', 2)
        xline(landing, 'r', 'Landing', 'LabelHorizontalAlignment', 'center', 'LabelOrientation', 'Horizontal', 'LineWidth', 2)
    else
        xline(takeoff, 'r', 'LineWidth', 2)
        xline(liftoff, 'r', 'LineWidth', 2)
        xline(TOC, 'r', 'LineWidth', 2)
        xline(landing, 'r', 'LineWidth', 2)
    end
end