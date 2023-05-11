close all
clearvars -except PITOT
PITOT = readtable("log_all.csv");

indicated = PITOT.indicated_airspeed;
indicated = indicated * 2.23694; %M/S to MPH
id = 1:length(indicated);

calibrated = [];
for a = 1:length(id)
    if indicated(a) > 25
        calibrated(a) = indicated(a) * 1.035;
    elseif indicated(a) > 15
        calibrated(a) = indicated(a) * 1.06;
    elseif indicated(a) > 10
        calibrated(a) = indicated(a) * 1.11;
    else
        calibrated(a) = indicated(a);
    end
end

indicated_airspeed = figure();
plot(id, indicated);
set(gca,'XTick',[], 'YTick', [])
ylim([0 40]);
xlim([0 2300]);
label = {'5', '8', '12', '14', '17', '20', '24', '28', '31', '33', '36'};
x = [5, 8, 12, 14, 17, 20, 24, 28, 31, 33, 36];
for i = 1:length(x)
    yline(x(i), 'Label', label(i), 'LabelVerticalAlignment', 'middle');
end
ylabel("mph")
title("Indicated Airspeed")

calibrated_airspeed = figure();
plot(id, calibrated);
set(gca,'XTick',[], 'YTick', [])
ylim([0 40]);
xlim([0 2300]);
label = {'5', '8', '12', '14', '17', '20', '24', '28', '31', '33', '36'};
x = [5, 8, 12, 14, 17, 20, 24, 28, 31, 33, 36];
for i = 1:length(x)
    yline(x(i), 'Label', label(i), 'LabelVerticalAlignment', 'middle');
end
ylabel("mph")
title("Calibrated Airspeed")
