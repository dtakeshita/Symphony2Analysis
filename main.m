code_root = '/Users/dtakeshi/Documents/MATLAB/ForSharing/Symphony2Analysis';
addpath(genpath(code_root))
dat_path = '/Users/dtakeshi/Documents/Data/FredPrimateData/parsedFiles';
ctype = 'On';
cname = 'SpikeCount_LedPulse10_2018-08-21_Ec2-Parsed';
dat = load(fullfile(dat_path,ctype,cname));
pre = dat.s.spc_pre.values;
post = dat.s.spc_post.values;
twoAFs_exp = calc2AFwithSpikeCount(dat.s.RstarMean, pre, post );

% Plotting 2AF curves
[fh_twoAF, h_exp] = plot_twoAFs(twoAFs_exp,cname,'Data','k');