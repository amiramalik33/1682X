clear all
close all

%% initialize simulation
p = get_params(3);
cdA_f = p("cdA_f");
rho_A = p("rho_A");
rho_W = p("rho_W");
S     = p("S");
m     = p("m");
g     = 9.8;
FT    = ComputeThrust(0); %get takeoff thrust

%values from XFLR5 for our wing
alpha = linspace(-4, 7, 12)*pi/180;
cl    = linspace(.328, 1.41, 12);
cds   = linspace(.010, .044, 12);

V = [];
%calculate V for given angle and check if it results in lift
for i = 1:length(alpha)
    V_calc = real(((2*FT*cos(alpha(i)))/(rho_A*(S*cds(i)+cdA_f)))^.5);
    if 2*m*g <= cl(i)*rho_A*S*(V_calc^2) %max ultralight speed 28m/s = 55knots
        V = [V V_calc];
    end
end

dt = .01;
swept_T = []; swept_X = []; confirm = [];

%% run simulation to climb 50' for a given speed
for i = 1:length(V)
    %time, x distance, y distance, x speed, y speed
    U = [0;0;0;V(i);0];
    while U(3, end) <= 16 %50 feet
        U_next = VFE_Next(U, dt, p, FT);
        U = [U,U_next];
    end
    swept_T = [swept_T, U(1, end)];
    swept_X = [swept_X, U(2, end)];
end

%% Plots

h1 = figure(1);
plot(V*1.944, swept_X, '-o')
title("Distance to Climb 50' for a Given Speed")
xlabel("Speed, knots")
ylabel("Distance, m")

h2 = figure(2);
plot(V*1.944, swept_T, '-o')
title("Time to climb 50' for a Given Speed")
xlabel("Speed, knots")
ylabel("Time, sec")