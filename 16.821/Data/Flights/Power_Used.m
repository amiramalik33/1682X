close all
clearvars -except DATA

%% Changeable

%filename = "AABV_flight1.csv";
%filename = "AABV_flight3.csv";

DATA = readtable(filename);

%% Manual File Stats
if filename == "AABV_flight1.csv"
    Name = 'First Flight';
    xlow = 7000;
    xhigh = 40000;
    takeoff = 8700; %start takeoff run
    liftoff = 12030; %liftoff from water
    TOC = 16000; %top of climb
    landing = 35160; %landing run
elseif filename == "AABV_flight3.csv"
    Name = 'Third Flight';
    xlow = 55400;
    xhigh = 86700;
    takeoff = 56400; %start takeoff run
    liftoff = 58000; %liftoff from water 
    TOC = 61200; %top of climb
    landing = 84200; %landing run
end

%% Power Calculations

V = DATA.Battery_Voltage;
I = DATA.Battery_Current;
P = V.*I;
t = DATA.Time;

E_TO = mean(P(takeoff:liftoff))*(liftoff-takeoff)/100;
E_TO = E_TO / 3600; %J to Wh
E_Climb = mean(P(liftoff:TOC))*(TOC-liftoff)/100;
E_Climb = E_Climb / 3600; %J to Wh
E_Cruise = mean(P(TOC:landing))*(landing-TOC)/100;
E_Cruise = E_Cruise / 3600; %J to Wh

clear filename landing liftoff Name takeoff TOC xhigh xlow




