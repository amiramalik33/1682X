function [alpha_opt, l_opt, v_plan, cda_min] = alphaOpt(Frmin,b,alpha0,l0)
    eps = 0.1;
    alpha = alpha0;
    l = 0;
    alpha_range_degs = 0:0.01:10;
    alpha_range = alpha_range_degs .* pi./180; 
    l = l0;
    for k = 1:100
    %while abs(l-l0) > eps
        Cl = CL(b,l,alpha);
        l = L(Cl,Frmin,b);
        v = V(Frmin,l);
        cda = CDA(b,l,v,alpha_range);
        %sens = 0.000001;
        [cda_ref, i] = min(cda);
        %cda_ref = (1 + sens) .* min(cda);
        %i = find(cda<cda_ref,1,'first');
        alpha = alpha_range(i);
        alpha_deg = alpha_range_degs(i);
    end
    alpha_opt = alpha_deg;
    l_opt = l;
    v_plan = v;
    cda_min = cda_ref;
end

function cl = CL(b,l,alph)
    AR = b./l;
    cl = (AR.*pi.*alph./4) + (0.88.*alph.^2);
end

function len = L(CL,Frmin,b)
    rho_w = 1000;
    m_max = 256;
    len = sqrt(m_max./(0.5.*rho_w.*(Frmin.^2).*b.*CL));
end

function vel = V(Frmin,l)
    g = 9.81;
    vel = Frmin.*sqrt(g.*l);
end

function [cda] = CDA(b,l,V,alph)
    %length(b)
    %length(l)
    %length(V)
    %length(alph)
    g = 9.81; rho_w = 1000; m = 256;
    W = m.*g; 
    qw = 0.5.*rho_w.*V.^2;
    k_v = 1.053.*10.^-6;
    Re = V.*l./k_v;
    cl = CL(b,l,alph);
    cdw = cl.*alph;
    %AR = b./l;
    %cl = (AR.*pi.*alph./4) + (0.88.*alph.^2);
    cda = W ./ qw .*(alph + (1.328./(sqrt(Re).*cl)));
    %cda = b.*l.*(cdw + (1.328./(sqrt(Re))));
end
