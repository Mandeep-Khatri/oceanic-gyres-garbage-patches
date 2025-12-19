# Oceanic Gyres and Garbage Patches Detection

This project analyzes ocean drifter NetCDF data to identify oceanic gyres and potential garbage patch regions using velocity-based methods.

## Overview
- Processes 1100+ ocean drifter `.nc` files
- Extracts latitude, longitude, and velocity components
- Detects gyre centers using minimum current speed
- Applies quality control to handle noisy or unrealistic data
- Generates trajectory and speed visualizations
- Combines all drifter trajectories into latitude and longitude matrices

## Methods
- Speed calculation: sqrt(ve^2 + vn^2) / sqrt(2)
- Gyre center identified at minimum speed location
- Outlier handling using threshold-based filtering
- Data stored as row-wise matrices (each row = one drifter)

## Tools Used
- MATLAB
- NetCDF data format
- NOAA / ERDDAP Ocean Drifter Dataset

## Files
- `analyze_single_gyre.m` – analyze and visualize a single drifter
- `save_all_drifter_plots_safe.m` – batch processing and plotting
- `make_lat_lon_matrices.m` – generate latitude and longitude matrices

## Data
NetCDF drifter files are not included due to size.
Download drifter data and place `.nc` files in the working directory.

