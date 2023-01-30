function [P_best, P_worst, P_med] = PowerEta(Snow, eta, eta_panel, rho, cd, cl, WSmin, irrad)
%takes in some variables and gives the power required, based on drag and
%velocity, and the power generated, based on some irradiance level and
%efficiencies. Returns three efficiency levels
    Preq_worst = Snow/eta(1).*sqrt(2/rho)*(cd/(cl^(3/2)))*WSmin^(3/2);
    Preq_best = Snow/eta(2).*sqrt(2/rho)*(cd/(cl^(3/2)))*WSmin^(3/2);
    P_gener_worst = eta(1)*eta_panel(1)*irrad*Snow;
    P_gener_best = eta(2)*eta_panel(2)*irrad*Snow;

    P_best  = P_gener_best/Preq_best;
    P_worst = P_gener_worst/Preq_worst;
    P_med   = (P_best+P_worst)/2;
    PP = P_gener_best

end