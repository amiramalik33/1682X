function mass = WingWeight(Snow, AR)
%returns wing weight as a function of wing area and aspect ratio
    %gelcoat
    w_g =  8/2.205/17; %pounds*convert to kg / wing area
    %covering
    w_c = 8.7/2.205/17;
    %ribs
    w_r = 15/2.205/17;
    %spar tube
    w_s = 44/2.205/18; %only weight that is done by wingspan
    %fixed weight
    w_f = 4/2.205; %aileron hinge weight

    b = sqrt(AR*Snow);

    mass = Snow*(w_g+w_c+w_r) + b*w_s + w_f;

end