import pandas as pd
import csv as csv
import numpy as np
from scipy import interpolate

filename = "flight1"
baro_correction = 1 #barometric data correction factor
true_correction = 1 #true airspeed correction factor
total_steps = range(1, 90001) #range of data to interpolate to, tenth seconds

#######################################################
#import the CSVs with panda

#make CSV names
solar = filename + "_battery_status_0.csv"
batt  = filename + "_battery_status_1.csv"
airdata = filename + "_vehicle_air_data_0.csv"
difpa = filename + "_differential_pressure_0.csv"
airspeed = filename + "_airspeed_validated_0.csv"
IMUangles = filename + "_vehicle_attitude_0.csv"
IMUrates = filename + "_vehicle_angular_velocity_0.csv"
GPS = filename + "_vehicle_gps_position_0.csv"
localpos = filename + "_vehicle_local_position_0.csv"
rcinput = filename + "_input_rc_0.csv"

#make panda datas
solar_data = pd.read_csv(solar)
battery_data = pd.read_csv(batt)

air_data = pd.read_csv(airdata)
pressure_data = pd.read_csv(difpa)
airspeed_data = pd.read_csv(airspeed)

angles_data = pd.read_csv(IMUangles)
angles_data.rename(columns={"q[0]": "q0"}, inplace=True)
angles_data.rename(columns={"q[1]": "q1"}, inplace=True)
angles_data.rename(columns={"q[2]": "q2"}, inplace=True)
angles_data.rename(columns={"q[3]": "q3"}, inplace=True)
angular_data = pd.read_csv(IMUrates)
angular_data.rename(columns={"xyz[0]": "x"}, inplace=True)
angular_data.rename(columns={"xyz[1]": "y"}, inplace=True)
angular_data.rename(columns={"xyz[2]": "z"}, inplace=True)


gps_data = pd.read_csv(GPS)
position_data = pd.read_csv(localpos)

rx_data = pd.read_csv(rcinput)
rx_data.rename(columns={"values[0]": "one"}, inplace=True)
rx_data.rename(columns={"values[1]": "two"}, inplace=True)
rx_data.rename(columns={"values[2]": "three"}, inplace=True)
rx_data.rename(columns={"values[3]": "four"}, inplace=True)
rx_data.rename(columns={"values[4]": "five"}, inplace=True)
rx_data.rename(columns={"values[5]": "six"}, inplace=True)

###################################################################
#Make the panda CSVs into lists
#Change initial time to zero
#Change microseconds to hundreths of seconds
#Interpolate all data into length total_steps

#make universal time
time = total_steps

#make power lists
time_mppt = pd.Series.tolist(solar_data.timestamp)
time_mppt = [x - time_mppt[0] for x in time_mppt]
time_mppt[:] = [x / 10000 for x in time_mppt]
mppt_v = pd.Series.tolist(solar_data.voltage_v)
mppt_v = np.interp(total_steps, time_mppt, mppt_v, left=0, right=0)
mppt_a = pd.Series.tolist(solar_data.current_a)
mppt_a = np.interp(total_steps, time_mppt, mppt_a, left=0, right=0)
mppt_mah = pd.Series.tolist(solar_data.discharged_mah)
mppt_mah = np.interp(total_steps, time_mppt, mppt_mah, left=0, right=0)

time_batt = pd.Series.tolist(battery_data.timestamp)
time_batt = [x - time_batt[0] for x in time_batt]
time_batt[:] = [x / 10000 for x in time_batt]
batt_v = pd.Series.tolist(battery_data.voltage_v)
batt_v = np.interp(total_steps, time_batt, batt_v, left=0, right=0)
batt_a = pd.Series.tolist(battery_data.current_a)
batt_a = np.interp(total_steps, time_batt, batt_a, left=0, right=0)
batt_mah = pd.Series.tolist(battery_data.discharged_mah)
batt_mah = np.interp(total_steps, time_batt, batt_mah, left=0, right=0)

#make air data lists
time_baro = pd.Series.tolist(air_data.timestamp)
time_baro = [x - time_baro[0] for x in time_baro]
time_baro[:] = [x / 10000 for x in time_baro]
time_airspeed = pd.Series.tolist(airspeed_data.timestamp)
time_airspeed = [x - time_airspeed[0] for x in time_airspeed]
time_airspeed[:] = [x / 10000 for x in time_airspeed]
#static_pressure = pd.Series.tolist(air_data.baro_pressure_pa)
#diff_pressure = pd.Series.tolist(pressure_data.differential_pressure_pa)
alt_baro = pd.Series.tolist(air_data.baro_alt_meter)
alt_baro = np.interp(total_steps, time_baro, alt_baro, left=0, right=0)
air_indicated = pd.Series.tolist(airspeed_data.indicated_airspeed_m_s)
air_indicated = np.interp(total_steps, time_airspeed, air_indicated, left=0, right=0)

#make IMU data lists
time_q = pd.Series.tolist(angles_data.timestamp)
time_q = [x - time_q[0] for x in time_q]
time_q[:] = [x / 10000 for x in time_q]
q0 = pd.Series.tolist(angles_data.q0)
q0 = np.interp(total_steps, time_q, q0, left=0, right=0)
q1 = pd.Series.tolist(angles_data.q1)
q1 = np.interp(total_steps, time_q, q1, left=0, right=0)
q2 = pd.Series.tolist(angles_data.q2)
q2 = np.interp(total_steps, time_q, q2, left=0, right=0)
q3 = pd.Series.tolist(angles_data.q3)
q3 = np.interp(total_steps, time_q, q3, left=0, right=0)

time_rate = pd.Series.tolist(angular_data.timestamp)
time_rate = [x - time_rate[0] for x in time_rate]
time_rate[:] = [x / 10000 for x in time_rate]
x_rate = pd.Series.tolist(angular_data.x)
x_rate = np.interp(total_steps, time_rate, x_rate, left=0, right=0)
y_rate = pd.Series.tolist(angular_data.y)
y_rate = np.interp(total_steps, time_rate, y_rate, left=0, right=0)
z_rate = pd.Series.tolist(angular_data.z)
z_rate = np.interp(total_steps, time_rate, z_rate, left=0, right=0)

#make GPS lists
time_gps = pd.Series.tolist(gps_data.timestamp)
time_gps = [x - time_gps[0] for x in time_gps]
time_gps[:] = [x / 10000 for x in time_gps]
lat = pd.Series.tolist(gps_data.lat)
lat = np.interp(total_steps, time_gps, lat, left=0, right=0)
lon = pd.Series.tolist(gps_data.lon)
lon = np.interp(total_steps, time_gps, lon, left=0, right=0)
alt_gps = pd.Series.tolist(gps_data.alt)
alt_gps = np.interp(total_steps, time_gps, alt_gps, left=0, right=0)
g_speed = pd.Series.tolist(gps_data.vel_m_s)
g_speed = np.interp(total_steps, time_gps, g_speed, left=0, right=0)

time_pos = pd.Series.tolist(position_data.timestamp)
time_pos = [x - time_pos[0] for x in time_pos]
time_pos[:] = [x / 10000 for x in time_pos]
heading = pd.Series.tolist(position_data.heading)
heading = np.interp(total_steps, time_pos, heading, left=0, right=0)
xpos = pd.Series.tolist(position_data.x)
xpos = np.interp(total_steps, time_pos, xpos, left=0, right=0)
ypos = pd.Series.tolist(position_data.y)
ypos = np.interp(total_steps, time_pos, ypos, left=0, right=0)
zpos = pd.Series.tolist(position_data.z)
zpos = np.interp(total_steps, time_pos, zpos, left=0, right=0)
xspeed = pd.Series.tolist(position_data.vx)
xspeed = np.interp(total_steps, time_pos, xspeed, left=0, right=0)
yspeed = pd.Series.tolist(position_data.vy)
yspeed = np.interp(total_steps, time_pos, yspeed, left=0, right=0)
zspeed = pd.Series.tolist(position_data.vz)
zspeed = np.interp(total_steps, time_pos, zspeed, left=0, right=0)
xaccel = pd.Series.tolist(position_data.ax)
xaccel = np.interp(total_steps, time_pos, xaccel, left=0, right=0)
yaccel = pd.Series.tolist(position_data.ay)
yaccel = np.interp(total_steps, time_pos, yaccel, left=0, right=0)
zaccel = pd.Series.tolist(position_data.az)
zaccel = np.interp(total_steps, time_pos, zaccel, left=0, right=0)

#make RC command lists
time_rx = pd.Series.tolist(rx_data.timestamp)
time_rx = [x - time_rx[0] for x in time_rx]
time_rx[:] = [x / 10000 for x in time_rx]
Lmotor = pd.Series.tolist(rx_data.one)
Lmotor = np.interp(total_steps, time_rx, Lmotor, left=0, right=0)
Rmotor = pd.Series.tolist(rx_data.two)
Rmotor = np.interp(total_steps, time_rx, Rmotor, left=0, right=0)
Lail = pd.Series.tolist(rx_data.three)
Lail = np.interp(total_steps, time_rx, Lail, left=0, right=0)
Rail = pd.Series.tolist(rx_data.four)
Rail = np.interp(total_steps, time_rx, Rail, left=0, right=0)
elevator = pd.Series.tolist(rx_data.five)
elevator = np.interp(total_steps, time_rx, elevator, left=0, right=0)
rudder = pd.Series.tolist(rx_data.six)
rudder = np.interp(total_steps, time_rx, rudder, left=0, right=0)

#####################################################################
#Make the new CSV

newfile = open("AABV_" + filename + ".csv", "w", newline='')
writer = csv.writer(newfile)

writer.writerow(["Time", "MPPT_Voltage", "MPPT_Current", "MPPT_mAh", 
                 "Battery_Voltage", "Battery_Current", "Battery_mAh", 
                 "Barometer_Altitude", "Indicated_Airspeed", 
                 "Q0", "Q1", "Q2", "Q3", 
                 "X_Angular_Rate", "Y_Angular_Rate", "Z_Angular_Rate", 
                 "Latitude", "Longitude", "GPS_Altitude", "Ground_Speed",  
                 "Heading", "X_Position", "Y_Position", "Z_Position", 
                 "X_Speed", "Y_Speed", "Z_Speed", 
                 "X_Accel", "Y_Accel", "Z_Accel", 
                 "Left_Motor", "Right_Motor", "Left_Aileron", "Right_Aileron",
                 "Elevator", "Rudder"])

for w in range(len(rudder)):
    writer.writerow([total_steps[w], mppt_v[w], mppt_a[w], mppt_mah[w], 
                     batt_v[w], batt_a[w], batt_mah[w], 
                     alt_baro[w], air_indicated[w],
                     q0[w], q1[w], q2[w], q3[w],
                     x_rate[w], y_rate[w], z_rate[w],
                     lat[w], lon[w], alt_gps[w], g_speed[w],
                     heading[w], 
                     xpos[w], ypos[w], zpos[w],
                     xspeed[w], yspeed[w], zspeed[w], 
                     xaccel[w], yaccel[w], zaccel[w], 
                     Lmotor[w], Rmotor[w], Lail[w], Rail[w],
                     elevator[w], rudder[w]])

newfile.close()