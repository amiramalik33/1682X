function TW = TW_fixedV(WS, cd, rho, V, k)
%takes in variables and a list of W/S to make a list of T/W, based on
%Snorri's textbook
    q = .5*rho*(V^2);
    TW = q*cd*(1./WS) + k*1/q*WS;
end