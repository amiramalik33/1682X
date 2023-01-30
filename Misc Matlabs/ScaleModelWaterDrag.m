
%% Initialize
%mass of object
m = .1; %kg
%scale of object
s = .20; %percent
%density of water
rho = 997; %kg/m^3

%load csv
%assign values to accel & times
A = [];
times = [];

%% Find Velocity

%find dt and initialize V
dt = times(1) - times(2);
V = [0];

%make velocities
for i=0:dt:length(A)
    V = [V, V(end)+A(i)*dt];
end

%% Compute and Scale CDA
CDA = (2*m*A)./(rho*V.^2);
avgCDA = mean(CDA);
fullCDA = avgCDA/(s^2);

%% Plot
h1 = figure(1);
plot(times, CDA)
hold on
xlabel('time, sec')
ylabel('CDA, m^2')
dim1 = [.2 .5 .3 .3];
str1 = s*100 + "% Scale Model CDA is " + avgCDA;
annotation('textbox',dim1,'String',str1,'FitBoxToText','on');
dim2 = [.5 .5 .3 .3];
str2 = "Full Scale CDA estimated" + fullCDA;
annotation('textbox',dim2,'String',str2,'FitBoxToText','on');



