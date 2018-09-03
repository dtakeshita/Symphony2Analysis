close all;
code_root = '/Users/dtakeshi/Documents/MATLAB/Symphony2Analysis';
addpath(genpath(code_root))
dat_path = '/Users/dtakeshi/Documents/Data/FredPrimateData/parsedFiles';
ctype = 'On';
cname = '2018-08-21_Ec1';
spt_file = sprintf('LedPulse10_%s-Parsed',cname);
spc_file = sprintf('SpikeCount_LedPulse10_%s-Parsed',cname);
dat_spt = load(fullfile(dat_path,ctype,spt_file));
dat = load(fullfile(dat_path,ctype,spc_file));
%% to-do for Off switch pre and post
pre = dat.s.spc_pre.values;
post = dat.s.spc_post.values;
twoAFs_exp = calc2AFwithSpikeCount(dat.s.RstarMean, pre, post );
%% calculate pre-firing rate?

%Plot Raster
drawRasterPerLightAmplitude(dat_spt)
my_annotation(cname)
% Plotting 2AF curves
[fh_twoAF, h_exp] = plot_twoAFs(twoAFs_exp,cname,'Data','k');
% mark 75% threshold in 2AF?

% plot dipper
figure;
plot_dipper(twoAFs_exp, 'Data','o-')