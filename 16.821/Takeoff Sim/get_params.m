function parameters = get_params(state)

% Physical Parameters
rho_A = 1.225;  %kg/m^3
rho_W = 997;    %kg/m^3
S = 1.5;        %m^2
m = 6.581;      %kg

% Fuselage Drag (hard-coded)
% /16 since 1/4 scale model
alpha   = [0, 2, 2]; %pre-plane angle, planing angle, climb angle
cdA_air = .1/64;
cdA_pln = .002/64;
cdA_wtr = .005/64;

% Wing Drag (hard-coded)
AOA   = linspace(0, 8, 9);
cl_w  = linspace(.728, 1.51, 9);
cds_w = linspace(.017, .055, 9);

cl    = [cl_w(alpha(1)+1), cl_w(alpha(2)+1), cl_w(alpha(3)+1)];
cds   = [cds_w(alpha(1)+1), cds_w(alpha(2)+1), cds_w(alpha(3)+1)];
cdA_b = [cdA_wtr, cdA_pln, 0];              %cdA of "boat" (fuselage under water)
cdA_f = [.7*cdA_air, 1.1*cdA_air, cdA_air]; %cdA of "fuse" (fuselage above water)

keys = ["alpha" "cl" "cds" "cdA_b" "cdA_f" "rho_A" "rho_W" "S" "m"];

values = [alpha(state)*pi/180, cl(state), cds(state), cdA_b(state), cdA_f(state), rho_A, rho_W, S, m];

parameters = dictionary(keys, values);

end