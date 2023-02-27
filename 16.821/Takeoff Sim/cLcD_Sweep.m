clear all
close all

%initialize storage arrays
swept_time = []; swept_xdis = []; swept_ydis = []; 
swept_xspeed = []; swept_yspeed = []; swept_power = [];

%modification values
%mod = [.8, .9, 1, 1.1, 1.2, 2, 3, 4, 4.5];
high = 3;
low  = .8;
size = 30;
mod1 = (high-low).*rand(size,1) + low;
mod2 = (high-low).*rand(size,1) + low;
clear high low

for i = 1:size

    %modify parameters
    p = get_params();
    p = mod_drag(p, mod1(i));
    p = mod_wing(p, mod2(i));

    %run simulation
    U = WaterTakeOff(p);

    %store end value of each state variable
    time       = U(1,end);
    x_distance = U(2,end)*3.281; %m to feet
    y_distance = U(3,end)*3.281;
    x_speed    = U(4,end)*1.944; %m/s to knots
    y_speed    = U(5,end)*196.9; %m/s to fpm
    instaPower = U(6,:); %instantaneous power at each dt, Watts/s
    
    power = sum(instaPower)*p("dt"); %Watts

    swept_time      = [swept_time, time];
    swept_xdis      = [swept_xdis, x_distance];
    swept_ydis      = [swept_ydis, y_distance];
    swept_xspeed    = [swept_xspeed, x_speed];
    swept_yspeed    = [swept_yspeed, y_speed];
    swept_power     = [swept_power, power];

    clear U time x_distance y_distance x_speed y_speed p
end

clear i size
%% Plots
h1 = figure(1);
tiledlayout(2,2)
[xq,yq] = meshgrid(-5:.1:5, -5:.1:5);

%time
nexttile
vq = griddata(mod1,mod2,swept_power,xq,yq);
mesh(xq,yq,vq)
hold on
scatter3(mod1, mod2, swept_power);
hold on
xlabel("parasitic drag modification");
ylabel("induced drag modification");
zlabel("power, watts");

%runway length
nexttile
vq = griddata(mod1,mod2,swept_xdis,xq,yq);
mesh(xq,yq,vq)
hold on
scatter3(mod1, mod2, swept_xdis);
hold on
xlabel("parasitic drag modification");
ylabel("induced drag modification");
zlabel("runway, feet");

%airspeed
nexttile
vq = griddata(mod1,mod2,swept_xspeed,xq,yq);
mesh(xq,yq,vq)
hold on
scatter3(mod1, mod2, swept_xspeed);
hold on
xlabel("parasitic drag modification");
ylabel("induced drag modification");
zlabel("airspeed, knots");

%vertical speed
nexttile
vq = griddata(mod1,mod2,swept_yspeed,xq,yq);
mesh(xq,yq,vq)
hold on
scatter3(mod1, mod2, swept_yspeed);
hold on
xlabel("parasitic drag modification");
ylabel("induced drag modification");
zlabel("vertical speed, fpm");


% %OG mod plots (2D)
% h1 = figure(1);
% tiledlayout(2,1)
% nexttile
% plot(mod, swept_xdis, "-o");
% hold on
% title("Constant Thrust Runway Length vs Drag")
% xlabel('drag multiplier')
% ylabel('distance, ft')
% nexttile
% title("Airspeed & Time to TakeOff")
% yyaxis left
% plot(mod, swept_xspeed)
% ylabel('Air Speed, knots')
% hold on
% yyaxis right
% plot(mod, swept_time)
% xlabel('drag multiplier')
% ylabel('Time, sec')

