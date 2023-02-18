function i_w = get_incidence(a_f, t, phi_G, CLalpha, W, rho, S, Vc, a_zl)
%{
a_f is lease fuselage drag angle
t is taper ratio of wing
phi_G is difference in twist angle (root-tip)
CLalpha is the lift curve slope
rho is air density
S is wing area
Vc is the cruise speed
a_zl is the zero lift angle of the airfoil
%}

%the correction for wing twist
phi_MGC = (1+2*t)/(3+3*t)*phi_G;
%midpoint cruise AOA
Wi = W;
Wf = W;
a_c = (1/CLalpha) * (Wi+Wf)/(rho*S*Vc^2) + a_zl;

%incidence angle
i_w = a_c + a_f - phi_MGC;

end