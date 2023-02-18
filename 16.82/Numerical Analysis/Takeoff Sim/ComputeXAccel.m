function d2xdt2 = ComputeXAccel(dxdt, cds, cdA_b, cdA_f, rho_A, rho_W, S, m, alpha, FT, cl)

V2 = dxdt^2;

g = 9.8;
Vto = (2*m*g/(cl* rho_A*S))^.5; %takeoff speed
Vp  = 11.5; %planing speed hard coded cuz im lazy

%approximating a decrease in cd during planing
if dxdt >= Vp && cdA_b ~= 0 
    slope = (-cdA_b)/(Vto-Vp);
    cdA_b_approx = slope*(dxdt-Vp)+cdA_b;
    cdA_b = cdA_b_approx;
%     cdA_b = (1.0668^2*pi*(alpha)^2)/4 + .88*(alpha)^3*8 + 1.328*8/((dxdt*8*(1.053*10^6))^.5)
    if cdA_b < 0
        cdA_b = 0;
    end
end
if dxdt < Vp 
    slope = (.002-cdA_b)/(Vp);
    cdA_b_approx = slope*(dxdt)+cdA_b;
    cdA_b = cdA_b_approx;
end

FDS = .5*cds*rho_A*S*V2;
FDA = .5*cdA_f*rho_A*V2;
FDW = .5*cdA_b*rho_W*V2;

d2xdt2 = (FT*cos(alpha) - (FDS + FDA + FDW))/m;  

end
