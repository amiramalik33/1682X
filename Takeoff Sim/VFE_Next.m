function U_next = VFE_Next(U, dt, p, FT)

alpha = p("alpha");
cl    = p("cl");
cds   = p("cds");
cdA_b = p("cdA_b");
cdA_f = p("cdA_f");
rho_A = p("rho_A");
rho_W = p("rho_W");
S     = p("S");
m     = p("m");

t    = U(1, end);
x    = U(2, end);
y    = U(3, end);
dxdt = U(4, end);
dydt = U(5, end);

t_next = t+dt;
d2ydt2 = ComputeYAccel(dxdt, cl, m, rho_A, S, alpha, FT);

%% Forward Euler
x_next = x + dxdt*dt;

dydt_next = dydt + d2ydt2*dt;
y_next = y + dydt*dt;

%% Return Statement
U_next = [t_next; x_next; y_next; dxdt; dydt_next];


end