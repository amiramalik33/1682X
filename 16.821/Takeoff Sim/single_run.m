clear all
close all

p = get_params();
U = WaterTakeOff(p);

%% Plots

time       = U(1,:); %seconds
x_distance = U(2,:)*3.281; %m to feet
y_distance = U(3,:)*3.281;
x_speed    = U(4,:)*1.944; %m/s to knots
y_speed    = U(5,:)*196.9; %m/s to fpm
instaPower = U(6,:); %Watts

power = sum(instaPower)*p("dt");

h1 = figure(1);
plot(x_distance, y_distance);
hold on
title("Takeoff Profile,Thrust = " + ComputeThrust(0) + " N")
xlabel('distance, ft')
ylabel('distance, ft')
yline(50, '-',"50' ft Obstacle");

h2 = figure(2);
title("Speed Profile,Thrust = " + ComputeThrust(0) + " N")
yyaxis left
plot(x_distance, x_speed)
ylabel('Air Speed, knots')
hold on
yyaxis right
plot(x_distance, y_speed)
xlabel('Runway, ft')
ylabel('Vertical Speed, fpm')

h3 = figure(3);
Vp_kt = p("Vp")*1.944; %m/s to knots
Vto_kt = ((2*p("m")*9.8/(p("cl1")* p("rho_A")*p("S")))^.5)*1.944; %takeoff speed in knots
plot(time, x_speed)
hold on
title("Airspeed vs Time, Thrust = " + ComputeThrust(0) + " N")
ylabel('Airspeed, knots')
xlabel('Time, sec')
yline(Vp_kt, '-',"Planing Speed");
yline(Vto_kt, '-', "Takeoff Speed");