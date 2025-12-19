% make_lat_lon_matrices.m
% Creates latitude and longitude matrices from multiple .nc drifter files
% Each row corresponds to one drifter

clear; clc;

dataDir = pwd;                  % folder with .nc files
files = dir(fullfile(dataDir, '*.nc'));
nFiles = length(files);

% Find maximum trajectory length
maxLen = 0;
for i = 1:nFiles
    fn = files(i).name;
    lat = ncread(fn, 'latitude');
    maxLen = max(maxLen, numel(lat));
end

% Preallocate matrices
LAT_matrix = nan(nFiles, maxLen);
LON_matrix = nan(nFiles, maxLen);

% Fill matrices
for i = 1:nFiles
    fn = files(i).name;
    lat = ncread(fn, 'latitude');
    lon = ncread(fn, 'longitude');

    LAT_matrix(i, 1:numel(lat)) = lat(:)';
    LON_matrix(i, 1:numel(lon)) = lon(:)';
end

% Save output
save('drifter_lat_lon_matrices.mat', 'LAT_matrix', 'LON_matrix');

fprintf('Saved successfully as drifter_lat_lon_matrices.mat\n');
fprintf('Size of LAT_matrix: %d x %d\n', size(LAT_matrix));
fprintf('Size of LON_matrix: %d x %d\n', size(LON_matrix));
