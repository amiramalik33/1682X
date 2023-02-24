# Simulation & Multi-Dimensional Optimization
## Summary
These scripts started off as a forward euler takeoff simulation and over the semester evolved into multi-dimensional optimization and monte carlo runs of the baseline simulation to find different sensitivities and coupling.

The Numerics folder hold the literal simulation elements, being the forward euler implementation as well as the calculation of forces. An explanation of the equations and assumptions are found in the .pdf

The Parameters folder hold all the relevant and write-able variables for the simulation, including drag, area, lift, densities, and more. There is some weird-ness in how the hash table for finding variables is implemented because MATLAB only recently released dictionaries and there's still some missing functionality compared to other languages. But, to see and change variables is quite simple.

The top-level files are different sweeps and monte carlos that call the simulation for any study into sensitivity and coupling. 

A high-level diagram of the code architecture will come soon.



