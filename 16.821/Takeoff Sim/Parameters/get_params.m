function parameters = get_params()

%Simulation Parameters
dt = .01;

%Planing Parameters
l = 2;      %planing length in meters
minF = 1;   %Froude number
Vp = minF*((l*9.8)^.5);
clear l minF

% Physical Parameters
rho_A = 1.225;  %kg/m^3
rho_W = 997;    %kg/m^3
S = 1.5;        %m^2
%m = 6.581;      %kg
m = 9.5; %real kg

% Fuselage Drag (hard-coded)
alpha   = [0, 2, 3]; %pre-plane angle, planing angle, climb angle
cdA_air = .004696; %Peter's RANS Fuselage, 0deg fixed Reynolds
clA_air = .00125;  %Peter's RANS Fuselage, 0deg fixed Reynolds
cdA_pln = .0005;   %Alberto's estimate, at trim angle
clA_pln = 0;
cdA_wtr = .0005;

% Wing Drag (hard-coded)
AOA   = linspace(0, 5, 6);
cl_w  = linspace(.668, 1.11, 6);
cds_w = linspace(.026, .06, 6);

cl    = [cl_w(alpha(1)+1), cl_w(alpha(2)+1), cl_w(alpha(3)+1)];
cds   = [cds_w(alpha(1)+1), cds_w(alpha(2)+1), cds_w(alpha(3)+1)];
cdA_b = [cdA_wtr, cdA_pln, 0];              %cdA of "boat" (fuselage under water)
cdA_f = [.7*cdA_air, 1.1*cdA_air, cdA_air]; %cdA of "fuse" (fuselage above water)

%apparently you can't map arrays to dictionary keys, stupid memory
keys = ["alpha1" "alpha2" "alpha3" "cl1" "cl2" "cl3" "cds1" "cds2" "cds3" ...
    "cdA_b1" "cdA_b2" "cdA_b3" "cdA_f1" "cdA_f2" "cdA_f3" ...
    "rho_A" "rho_W" "S" "m", "Vp", "dt"];

values = [alpha*pi/180, cl, cds, cdA_b, cdA_f, rho_A, rho_W, S, m, Vp, dt];

parameters = dictionary(keys, values);

end