
# Coordinate Estimate Function

This function estimates coordinates using satellite data read from a specific SP3 file.

## Function Signature

function [X_Coordinates,Y_Coordinates,Z_Coordinates] = Coordinate_Estimate(sp3_file)

##Parameters
sp3_file: The path to the SP3 file. This file contains the satellite data.
##Outputs
X_Coordinates: The estimated values of the satellite’s X coordinates.
Y_Coordinates: The estimated values of the satellite’s Y coordinates.
Z_Coordinates: The estimated values of the satellite’s Z coordinates.
Function Operation
The function estimates the X, Y, and Z coordinates for each satellite. These estimates are made using Lagrange interpolation. Separate estimates are made for each axis (X, Y, and Z) for each satellite.

The estimates are performed over specific subsets of the satellite data. These subsets are determined based on the position of the data point. The data point could be at the beginning, middle, or end of the data set.

In conclusion, this function estimates satellite coordinates using satellite data from a specific SP3 file.
