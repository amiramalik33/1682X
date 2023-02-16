function parameters = get_params(state)

% hard-coded from aero team analysis
alpha   = [0, 2, 2]; %pre-plane angle, planing angle, climb angle
cdA_air = .2;
cdA_pln = .002;
cdA_wtr = .005;

%values from XFLR5 for our wing
AOA   = linspace(0, 8, 9);
cl_w  = linspace(.728, 1.51, 9);
cds_w = linspace(.017, .055, 9);

cl    = [cl_w(alpha(1)+1), cl_w(alpha(2)+1), cl_w(alpha(3)+1)];
cds   = [cds_w(alpha(1)+1), cds_w(alpha(2)+1), cds_w(alpha(3)+1)];
cdA_b = [cdA_wtr, cdA_pln, 0];              %cdA of "boat" (fuselage under water)
cdA_f = [.7*cdA_air, 1.1*cdA_air, cdA_air]; %cdA of "fuse" (fuselage above water)

rho_A = 1.225;
rho_W = 997;
S = 26;
m = 256;

keys = ["alpha" "cl" "cds" "cdA_b" "cdA_f" "rho_A" "rho_W" "S" "m"];

values = [alpha(state)*pi/180, cl(state), cds(state), cdA_b(state), cdA_f(state), rho_A, rho_W, S, m];

parameters = dictionary(keys, values);

end