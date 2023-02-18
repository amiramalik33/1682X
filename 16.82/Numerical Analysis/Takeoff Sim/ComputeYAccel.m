function d2ydt2 = ComputeYAccel(dxdt, cl, m, rho_A, S, alpha, FT)

g = 9.8; %m/s^2

V2 = dxdt^2;
FG = m*g;
FL = .5*cl*rho_A*S*V2;
T  = FT*sin(alpha);

if (FL + T) < FG
    d2ydt2 = 0;
else
    d2ydt2 = (FL + T - FG)/m;
end

end