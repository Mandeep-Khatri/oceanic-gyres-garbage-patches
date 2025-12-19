% save_all_drifter_plots_safe.m
% Loops through all drifter files, applies QC, and saves plots safely

clear; clc;

dataDir = pwd;
outDir  = fullfile(dataDir, 'error_drifters');

if ~exist(outDir, 'dir')
    mkdir(outDir);
end

files = dir(fullfile(dataDir, '*.nc'));
nFiles = length(files);

speedThreshold = 2.0;   % m/s threshold for unrealistic speeds

for i = 1:nFiles
    filename = files(i).name;
    fprintf('Processing %s (%d of %d)\n', filename, i, nFiles);

    try
        lat = ncread(filename, 'latitude');
        lon = ncread(filename, 'longitude');
        ve  = ncread(filename, 've');
        vn  = ncread(filename, 'vn');

        S = sqrt(ve.^2 + vn.^2);

        % Check for unrealistic speed
        if any(S > speedThreshold)
            warning('%s: Unrealistically high speed detected (%.2f m/s).', ...
                    filename, max(S));
        end

        % Plot speed profile
        fig = figure('Visible','off');
        plot(S, 'b');
        xlabel('Sample index');
        ylabel('Speed (m/s)');
        title(['Speed profile for ', filename]);
        grid on;

        % Save figure
        outFile = fullfile(outDir, [erase(filename,'.nc'), '_speed.png']);
        saveas(fig, outFile);
        close(fig);

    catch ME
        warning('Failed to process %s: %s', filename, ME.message);
    end
end

disp('All files processed.');
