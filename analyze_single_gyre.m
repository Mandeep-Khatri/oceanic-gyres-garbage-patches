% analyze_single_gyre.m
% Analyze one drifter .nc file and compute speed statistics

function info = analyze_single_gyre(filename)

lat = ncread(filename, 'latitude');
lon = ncread(filename, 'longitude');
ve  = ncread(filename, 've');
vn  = ncread(filename, 'vn');

% Speed magnitude
S = sqrt(ve.^2 + vn.^2);

% Summary information
info = struct();
info.filename     = filename;
info.nPoints      = numel(lat);
info.lonSpanDeg   = max(lon) - min(lon);
info.latSpanDeg   = max(lat) - min(lat);
info.minSpeed     = min(S);
info.maxSpeed     = max(S);
info.medianSpeed  = median(S);
info.zeroVelFrac  = mean((ve == 0) & (vn == 0));

% Plot speed time series
figure('Visible','on');
plot(S, 'b');
xlabel('Sample index');
ylabel('Speed (m/s)');
title(['Speed time series – ', filename]);
grid on;

end
