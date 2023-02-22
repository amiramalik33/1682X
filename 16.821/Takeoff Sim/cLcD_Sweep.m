clear all
close all

%initialize storage arrays
swept_time = []; swept_xdis = []; swept_ydis = []; 
swept_xspeed = []; swept_yspeed = [];

%modification values
mod = [.8, .9, 1, 1.1, 1.2, 1.3, 1.45];

for i = 1:length(mod)

    %modify parameters
    p = get_params();
    p = mod_params(p, mod(i));

    %run simulation
    U = WaterTakeOff(p);

    %store end value of each state variable
    time =       U(1,end);
    x_distance = U(2,end)*3.281; %m to feet
    y_distance = U(3,end)*3.281;
    x_speed =    U(4,end)*1.944; %m/s to knots
    y_speed =    U(5,end)*196.9; %m/s to fpm

    swept_time      = [swept_time, time];
    swept_xdis      = [swept_xdis, x_distance];
    swept_ydis      = [swept_ydis, y_distance];
    swept_xspeed    = [swept_xspeed, x_speed];
    swept_yspeed    = [swept_yspeed, y_speed];

    clear U time x_distance y_distance x_speed y_speed p
end

clear i
%% Plots

h1 = figure(1);
plot(mod, swept_xdis, "-o");
hold on
title("Constant Thrust Runway Length vs Drag")
xlabel('drag multiplier')
ylabel('distance, ft')