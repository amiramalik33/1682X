function U_next = FE_Next(U, dt, p)

%constant parameters
rho_A   = p("rho_A");
rho_W   = p("rho_W");
S       = p("S");
m       = p("m");
Vp      = p("Vp");

%dictionary magic
alpha   = [p("alpha1"), p("alpha2"), p("alpha3")];
cl      = [p("cl1"), p("cl2"), p("cl3")];
cds     = [p("cds1"), p("cds2"), p("cds3")];
cdA_b   = [p("cdA_b1"), p("cdA_b2"), p("cdA_b3")];
cdA_f   = [p("cdA_f1"), p("cdA_f2"), p("cdA_f3")];

if (U(4, end) <= Vp && U(5, end) <= 0.1) 
    state = 1; %pre-planing
elseif (U(4, end) > Vp && U(5, end) <= 0.1) 
    state = 2; %is planing
elseif (U(5, end) > 0.1) 
    state = 3; %post-liftoff
end

alpha   = alpha(state);
cl      = cl(state);
cds     = cds(state);
cdA_b   = cdA_b(state);
cdA_f   = cdA_f(state);

t    = U(1, end);
x    = U(2, end);
y    = U(3, end);
dxdt = U(4, end);
dydt = U(5, end);
FT = ComputeThrust(dxdt);

t_next = t+dt;
d2xdt2 = ComputeXAccel(dxdt, cds, cdA_b, cdA_f, rho_A, rho_W, S, m, alpha, FT, cl, Vp);
d2ydt2 = ComputeYAccel(dxdt, cl, m, rho_A, S, alpha, FT);

%% Forward Euler
dxdt_next = dxdt + d2xdt2*dt;
x_next = x + dxdt*dt;

dydt_next = dydt + d2ydt2*dt;
y_next = y + dydt*dt;

%% Return Statement
U_next = [t_next; x_next; y_next; dxdt_next; dydt_next];

end