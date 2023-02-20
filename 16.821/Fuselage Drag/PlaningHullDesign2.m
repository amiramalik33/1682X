% Alberto Pena
% Diving Deeper into the Planing Hull Analysis
% 11/19/2022

clear
clf
clc

%% Finding Minimum Surface Area and Volume
% Minimum sizing due to weight and geometry constraint.
mstoknots = 1.94384; mtoft = 3.2808399; degtorads = 0.01745329;
rho_w = 1000; % kg m-3, density of water
mu_w = 1.31.*10.^-3; % Pa s, dynamic viscosity of water @ 10 degrees Celsius
Fr_min = 1.5; ; % nums given in the "planing" module
CL_hull = 0:0.001:0.1; % Going to graph the relationship of planing hull
g = 9.8065; m_max = 256; % m s-2; kg,  max weight of the system
l_plan = 3.05; % m == 10 ft, a number that is up for debate, but that we can change
k_b = 1.1; % buoyancy margin factor
k_s = 1.1;

V = Fr_min .* sqrt(g.*l_plan);
V_kts = V.*mstoknots % we takeoff at around 28 kts this is about half way when we transition to planing regime
S_min = k_s.*(m_max.*g)./(0.5.*rho_w.*(V.^2).*CL_hull);
Vol_min = k_b.*(m_max)./rho_w

S_min_ft2 = S_min.*mtoft.^2;
figure(1)
plot(CL_hull,S_min_ft2,'-b','LineWidth',2)
hold on
title('Minimum Planing Surface Area vs Hydrodynamic Lift')
xlim([0.01 0.1])
xlabel('Hydrodynamic Lift')
ylabel('Minimum Planing Surface Area [ft^2]')
hold off

% Some Key Takeways
% 1. This suggests that if we want to reduce surface area, we are gonna have
% to increase CL. 

% 2. It also suggests that changes in CL will affect the planing hull surface
% area more btwn CL = 0.01:0.01:0.05 and CL = 0.05:0.01:0.1;

% 3. Also, the longer the planing surface, the higher the planing velocity,
% which decreases the minimum planing surface area, but is bounded but our
% takeoff velocity if we dont want to be stuck. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Fr_min_plan = 1:0.01:2;
%length(Fr_min_plan);
%l = linspace(5,20,101)./mtoft;
%V_plan = Fr_min_plan'*sqrt(g.*l)
%figure(2)
%contourf(Fr_min_plan,l.*mtoft,V_plan)
%colorbar
%hold on
%title('Planing Velocity vs Fr and Planing Surface Length')
%xlabel('Froude Number')
%ylabel('Planing Hull Length [ft]')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% So we get that as the Froude number increases the planing velocity
% increases, but upon increasing the planing velocity, we decrease the
% minumum planing area. This can be solved 

l = 8.5./mtoft;
CL_hull = 0.05;
V = Fr_min_plan.*sqrt(g.*l);
S_min_plan = k_s.*(m_max.*g)./(0.5.*rho_w.*(V.^2).*CL_hull);

figure(3)
hold on
subplot(2,1,1)
hold on
title('Effects of Fr on Planing Velocity ')
plot(Fr_min_plan,V.*mstoknots,'-b','LineWidth',2)
xlabel('Froude Number')
ylabel('Velocity [kts]')
plot(Fr_min_plan(51),V(51).*mstoknots,'.r','MarkerSize',15)
hold off

subplot(2,1,2)
hold on
title('Effects of Fr on Minimum Planing Surface Area')
plot(Fr_min_plan,S_min_plan.*(mtoft.^2),'-b','LineWidth',2)
xlabel('Froude Number')
ylabel('Minimum Planing Surafce Area [ft^2]')
plot(Fr_min_plan(51),S_min_plan(51).*(mtoft.^2),'.r','MarkerSize',15)
hold off
hold off

% This is a great image that shows how Fr number affects both the minimum
% planing surface area and the velocity. I think understanding how the
% planing surface area and the planing hull velocity affect hydrodynamic
% drag is important, because then we can do some sort of optimization where
% we try to minimize that drag to get better take off performance. 
% Well we know that in planing D/L can be approximated as alpha + (Cdf/CL).
% We are trying to keep D/L low. Cdf is proportional to the Re which is
% proportional to the submerged length. The longer the submerged length,
% the lower the parasitic drag is. 

% 4. Since there is a literal step when , we can have a relationship btwn
% the length of the planing surface and the length of the entire hull. If
% you were to plot froude number over time u would see a step from 1 to
% Fr_min at the planing velocity. This suggests that sqrt(g*l_hull) =
% Fr_min*sqrt(g*l_plan); rearranging the equation you get that :

l_tot = l_plan.*Fr_min.^2;
l_tot_ft = l_tot.*mtoft;

%% Area estimate

% In my previous analysis, I guessed the area to be:
%               Planing Area = (beam) * (submerged length)
% However, it is lies somewhere between b*l and 0.5*b*l.
% Therefore, we can chose a k_a value between 0.5 and 1 that will more
% accurately approximate the planing surface area. In fact, we can make a
% graph of how our k_a value effects our estimates for the beam length and
% height. 

% How does this effect our aspect ratio equation? 
% Well, AR = b^2/S so our new equation would be something like AR = b/(k*l)
% suggesting that the aspect ratio increases the more of a triangle shape
% the planing surface area looks like for a given surface area.

k_S = 1.2; % surface area margin constant.
k_a = 0.5:0.01:1;
alpha = 5.*degtorads % designed for 5 degrees trim.
ARd = 0.25; 
CL_h_d = (pi./4).*ARd.* alpha + 0.88.*(alpha.^2); % From planing.pdf
l_d = (m_max./(0.5.*rho_w.*ARd.*k_S.*(k_a.^2).*CL_h_d.*(Fr_min.^2))).^(1./3); 
l_ft_d = l_d.*mtoft;
b_ft_d = ARd.*l_ft_d.*k_a.*k_S;
S_ft2 = l_ft_d.*b_ft_d.*k_a.*k_S;

figure(4)
hold on

subplot(3,1,1)
hold on
plot(k_a,l_ft_d,'-b','LineWidth',2)
title('Effects of the area constant on the length of the planing surface @ AR = 0.25')
xlim([0.5 1])
xlabel('Area Constant k_a')
ylabel('Planing Surface Length [ft]')
hold off

subplot(3,1,2)
hold on 
plot(k_a,b_ft_d,'-b','LineWidth',2)
title('Effects of the area constant on the beam of the planing surface @ AR = 0.25')
xlim([0.5 1])
xlabel('Area Constant k_a')
ylabel('Beam [ft]')
hold off

subplot(3,1,3)
hold on 
plot(k_a,S_ft2,'-b','LineWidth',2)
title('Effects of the area constant on the area of the planing surface @ AR = 0.25')
xlim([0.5 1])
xlabel('Area Constant k_a')
ylabel('Area [ft^2]')
hold off
hold off

% What is this telling me, well, keeping the aspect ratio the same, the
% length increases, but this increase in length actually reduces the
% minimum surface area needed for planing by increasing the planing
% velocity, which again shows that tradoff. 

% NOTE: I designed the hull to have a AR of 0.4 and a k_a value of 1. You
% can adjust the ARd val above to see how l and b change with AR. 

% NOTE: multiply the lengths above by 2.25 and you will get what the
% estimated hull length should before planing (i.e. the total hull length).
% 2.25 was derived from a Fr_min of 1.5. Simply put, the ratio of the length
% of the planing surface and the length of the entire hull should be
% Fr_min^2. 

%% Seeing how AR changes S_min

% It would be easier to explain than to show a graph, but now we have come
% to the conclusion that a more triangular planing surface == minimizes the
% necessary planing surface area by increasing the length of the planing
% hull. However this increases the planing velocity which we want to occur
% relatively quickly in the take-off process so that hydrodynamic drag is
% significantly reduced. 

% Based of the equations, AR increases the CL_hydro of the planing surfaces
% which decreases the necessary planing surface area. I mean the further we
% reduce the planing surface area the lower the hydrodynamic drag during
% planing. However, seaplanes normally have a low aspect ratio because low
% ratios suggest a more slender body for plane, which reduces the body drag
% during cruise.

%% What is next?

% Well we can right some code that can approximate the take-off. however I
% still need to look into how to calculate hydrodynamic drag before
% planing. 

% We need to run some loading analysis so that we can choose a material
% that is durable enough to sustain landing impacts from the water. 

% Adding additional things like a water rudder/skeg, sister keelsons, spray
% rails, etc. should be done after refining most of our things.

% Step placement for hydrodynamic stability (should be 10 degrees to 15
% degrees from the CoG vertical apparently, prevents porpoising and
% skipping effects). 

% Most importantly, hydrostatic stability and bouyancy. With our planing
% hull, how does the plane sit on the water. Is the metacenter height
% positive for a good margin of delta y and delta x (ie longitudinal and
% transverse hydrostatic stability). Metacenter should be positve bc it
% would suggest that the bouyancy force will produce a restoring moment if
% the seaplane is displaced at some heave angle. 


