% Approximating the Fuselage as an axis symmetric body with 4.5 ft in
% diameter and 20 ft in length

clear
clc

fttom = 0.3048;
l = 20; 
d = 4.5; % in feet
% b = 3.5; h = 4.5;
ktstoms = 0.5144444;
mu_air = 18.03.*10.^-6; 
rho_air = 1.121;
V_cruise_kts = 33;
V_cruise_ms = ktstoms.*V_cruise_kts;
k_Re = rho_air.*V_cruise_ms./mu_air;

dOverL = d./l
fineness_ratio = 1./dOverL
Kf = 1 + 1.5.*(dOverL.^(1.5)) + 7.*(dOverL.^3)

Re_l = k_Re.*l.*fttom
Cdf = 0.455./((log10(Re_l)).^2.58)

% Swet = 5; % m^2
Swet = 0.8.*l.*pi.*d.*(fttom.^2);
SwOverSfrontal = 3.*fineness_ratio;
% Swet = (pi.*(d./2).^2).*(fttom.^2)
% Swet = (pi.*(d./2).^2).*(fttom.^2) .* 0.8; % Equation I got from 
CDA_wet_fuse = Swet.*Cdf.*Kf
CDA_frontal_fuse = CDA_wet_fuse.*SwOverSfrontal;
q_cruise = 0.5.*rho_air.*(V_cruise_ms.^2);
D_fuse = q_cruise.*CDA_wet_fuse;
P_fuse = V_cruise_ms.*D_fuse;


% Bouyancy
alpha_trim = 4;
alpha_stern = 8;
b = 1.0668;
