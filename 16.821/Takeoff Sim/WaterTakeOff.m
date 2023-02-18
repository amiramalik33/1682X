close all
clear all

%% States Definition
%State 1 is pre-planing
%State 2 is planing, when x-speed reached planing speed, in m/s
%State 3 is liftoff, when y-speed is non-zero
p  = get_params(2); %use state 2 for takeoff speed, in graph below
Vp = p("Vp");

%% Initialize Simulation
%time, x distance, y distance, x speed, y speed
U = [0;0;0;0;0];
dt = .01;

%% Takeoff Simulation (method-agnostic)

while U(3, end) <= 16 %50 feet
    if (U(4, end) <= Vp && U(5, end) <= 0.1) %pre-planing
        U_next = FE_Next(U, dt, 1);
        U = [U,U_next];
    elseif (U(4, end) > Vp && U(5, end) <= 0.1) %is planing
        U_next = FE_Next(U, dt, 2);
        U = [U,U_next];
    elseif (U(5, end) > 0.1) %acheive liftoff
        U_next = FE_Next(U, dt, 3);
        U = [U,U_next];
    end
end

%% Plots

time =       U(1,:);
x_distance = U(2,:)*3.281; %m to feet
y_distance = U(3,:)*3.281;
x_speed =    U(4,:)*1.944; %m/s to knots
y_speed =    U(5,:)*196.9; %m/s to fpm

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
Vp_kt = Vp*1.944; %m/s to knots
cl    = p("cl");
rho_A = p("rho_A");
S     = p("S");
m     = p("m");
g     = 9.8;
Vto_kt = ((2*m*g/(cl* rho_A*S))^.5)*1.944; %takeoff speed in knots
plot(time, x_speed)
hold on
title("Airspeed vs Time, Thrust = " + ComputeThrust(0) + " N")
ylabel('Airspeed, knots')
xlabel('Time, sec')
yline(Vp_kt, '-',"Planing Speed");
yline(Vto_kt, '-', "Takeoff Speed");
clear p cl rho_A S m g Vp
