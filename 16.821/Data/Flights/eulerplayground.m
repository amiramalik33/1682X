close all
clearvars -except DATA

filename = "AABV_flight1.csv";
%DATA = readtable(filename);

Euler = q2eul(DATA.Q0, DATA.Q1, DATA.Q2, DATA.Q3);

X = Euler(:,1);
Y = Euler(:,2);
Z = Euler(:,3);

overview=tiledlayout(3,1, "TileSpacing","tight", "Padding", "tight");

nexttile;
plot(X)
hold on
yline(0)
subtitle('Roll')

nexttile;
plot(Y)
hold on
yline(0)
subtitle('Pitch')

nexttile;
plot(Z)
hold on
subtitle('Yaw')

