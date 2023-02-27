function U = WaterTakeOff(p)

%% States Definition
%State 1 is pre-planing
%State 2 is planing, when x-speed reached planing speed, in m/s
%State 3 is liftoff, when y-speed is non-zero

%% Initialize Simulation
%time, x distance, y distance, x speed, y speed, power
U = [0;0;0;0;0;0];
dt = p("dt");

%% Takeoff Simulation

while U(3, end) <= .5 %3 feet
        U_next = FE_Next(U, dt, p);
        U = [U,U_next];
end

end