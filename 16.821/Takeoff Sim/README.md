# Simulation & Multi-Dimensional Optimization

## Code Flow
There will be an actual diagram soon.

Run cLcDSweep, it creates parameters with get_params() and then modifies parameters using mod_drag() and mod_wing() using a standard probability distribution. For each run, it calls WaterTakeOff(parameters) and then gets the end time, distance, and speeds.

WaterTakeOff is a forward euler 2D simulation. It calls FE_next which first gets the forces at a particular time by calling ComputeThrust, ComputeXAccel and ComputeYAccel, and then does the forward euler and returns the t+dt state to WaterTakeOff which will call FE_next until its run condition is satisfied (e.g. the aircraft reaches 50' altitude).

## Summary
These scripts started off as a forward euler takeoff simulation and over the semester evolved into multi-dimensional optimization and monte carlo runs of the baseline simulation to find different sensitivities and coupling.

The Numerics folder hold the literal simulation elements, being the forward euler implementation as well as the calculation of forces. An explanation of the equations and assumptions are found in the .pdf

The Parameters folder hold all the relevant and write-able variables for the simulation, including drag, area, lift, densities, and more. There is some weird-ness in how the hash table for finding variables is implemented because MATLAB only recently released dictionaries and there's still some missing functionality compared to other languages. But, to see and change variables is quite simple.

The top-level files are different sweeps and monte carlos that call the simulation for any study into sensitivity and coupling. 

A high-level diagram of the code architecture will come soon.



