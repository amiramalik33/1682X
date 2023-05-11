ail = (DATA.Right_Aileron)/1000 - 1.5;
ail = mov_avg(ail, 50);

overview=tiledlayout(3,1);
set(overview,'defaultLegendAutoUpdate','off');

nexttile;
plot(DATA.Time, ail);
title("Aileron Command");
ylabel("Percentage")
ylim([-.5,.5]);
eventlines(takeoff, liftoff, TOC, landing);

nexttile;
plot(DATA.Time, DATA.X_Angular_Rate*180/pi);
title("Roll Rate");
ylabel("Degrees/Sec")
ylim([-45 45])
eventlines(takeoff, liftoff, TOC, landing);

nexttile;
plot(DATA.Time, Roll);
title("Roll Angle");
ylabel("Degrees")
ylim([-45 45])
eventlines(takeoff, liftoff, TOC, landing);

title(overview,'Roll Control')
xlabel("time, centiseconds from start")
linkaxes(overview.Children,'x')
xlim([xlow, xhigh])


function eventlines(takeoff, liftoff, TOC, landing)
    xline(takeoff, 'r', 'Takeoff', 'LabelHorizontalAlignment', 'center', 'LabelOrientation', 'Horizontal', 'LineWidth', 2)
    xline(liftoff, 'r', 'Liftoff', 'LabelHorizontalAlignment', 'center', 'LabelOrientation', 'Horizontal', 'LineWidth', 2)
    xline(TOC, 'r', 'TOC', 'LabelHorizontalAlignment', 'center', 'LabelOrientation', 'Horizontal', 'LineWidth', 2)
    xline(landing, 'r', 'Landing', 'LabelHorizontalAlignment', 'center', 'LabelOrientation', 'Horizontal', 'LineWidth', 2)
end