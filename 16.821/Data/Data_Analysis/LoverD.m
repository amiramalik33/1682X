%flight3
close all

xstart = 67031;
xend = 68333;
xavg = (68333+67031)/2;

airspeed = 20; %knots
airspeed = airspeed*1.688; %knots to feet/second

seconds = (xend-xstart)/100;

alt_loss = Altitude(67031)-Altitude(68333);

distance = airspeed*seconds;

distance/alt_loss;

avg_air  = mean(Airspeed(67031:68333));
avg_sink = mean(DATA.Z_Speed(67031:68333));

avg_air/avg_sink;

v_speed = diff(Altitude(67031:68333))./transpose(diff(DATA.Time(67031:68333)));
v_speed = [0 v_speed];

Distance = [0];
for i = 1:length(Airspeed)
    dist = Airspeed(i)*1.688*.01;
    dist = Distance(i) + dist;
    Distance = [Distance dist];    
end
Distance = Distance - Distance(xstart);

jitterAmount = .3;
jitterValuesX = 2*(rand(size(xstart:8:xend))-0.5)*jitterAmount;   % +/-jitterAmount max
jitterValuesY = 2*(rand(size(xstart:8:xend))-0.5)*jitterAmount;   % +/-jitterAmount max

h3 = figure();
scatter(Distance(xstart:8:xend)+jitterValuesX, Altitude(xstart:8:xend)+jitterValuesY, 'MarkerEdgeAlpha', 0.5);
hold on
P = polyfit(Distance(xstart:xend), Altitude(xstart:xend), 1);
fit = polyval(P,Distance(xstart:xend));
plot(Distance(xstart:xend), fit);
xlabel('Distance Flown, feet')
ylabel('Altitude, feet')
yticks([30 40 50])
title('Flight Profile')
xticks([0 25 50 100 200])
axis equal
xlim([0 200])
ylim([20 60])

eqn = string("y = " + P(1)) + "x + " + string(P(2));
text(max(Distance(xstart:xend)),max(Altitude(xstart:xend)),eqn,"HorizontalAlignment","right","VerticalAlignment","top")

