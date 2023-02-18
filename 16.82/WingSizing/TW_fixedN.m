function TW = TW_fixedN(WS, cd, rho, V, k, n)
    q = .5*rho*(V^2);
    TW = q*(cd./WS + k*(n/q)^2 * WS);
end