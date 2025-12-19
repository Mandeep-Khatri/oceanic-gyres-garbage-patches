%% ============================================================
%  analyze_single_gyre.m
%  Visualize and analyze drifter trajectory from 1.nc
%  Author: [Your Name]
%  Purpose: Identify gyre / garbage patch zone from single drifter data
%% ============================================================

clear; clc; close all;

%% Step 1 — Load data from NetCDF file
filename = '1.nc';

% Read variables (adjust names if your ncdisp showed different ones)
lat = ncread(filename, 'latitude');
lon = ncread(filename, 'longitude');
ve  = ncread(filename, 've');   % eastward velocity
vn  = ncread(filename, 'vn');   % northward velocity

%% Step 2 — Compute speed (normalized)
S = sqrt(ve.^2 + vn.^2) / sqrt(2);

%% Step 3 — Plot the drifter trajectory
figure;
plot(lon, lat, '-b', 'LineWidth', 1.5)
xlabel('Longitude'); ylabel('Latitude');
title('Drifter Trajectory within Gyre');
grid on;

%% Step 4 — Plot speed along path
figure;
scatter(lon, lat, 30, S, 'filled');
colorbar;
xlabel('Longitude'); ylabel('Latitude');
title('Speed along Drifter Path — Blue = Slow (Gyre Center)');
set(gca, 'FontSize', 10);
grid on;

%% Step 5 — Identify slowest (patch) point
[minSpeed, idx] = min(S);
lon_center = lon(idx);
lat_center = lat(idx);
fprintf('🌀 Likely Gyre Center / Garbage Patch near:\n');
fprintf('   Longitude = %.3f°, Latitude = %.3f°, Speed = %.4f m/s\n', ...
        lon_center, lat_center, minSpeed);

hold on;
scatter(lon_center, lat_center, 80, 'r', 'filled');
text(lon_center, lat_center, '  Patch Center', 'Color','r','FontWeight','bold');

%% Step 6 — Animate the drifter movement (optional)
figure;
for i = 1:50:length(lat)
    plot(lon(1:i), lat(1:i), '-b', 'LineWidth', 1.5); hold on;
    scatter(lon(i), lat(i), 50, 'r', 'filled');
    xlabel('Longitude'); ylabel('Latitude');
    title(sprintf('Drifter Motion — Frame %d of %d', i, length(lat)));
    grid on;
    pause(0.05);
    hold off;
end
