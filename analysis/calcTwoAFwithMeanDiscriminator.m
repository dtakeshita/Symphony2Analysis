clear;
close all;
dat_path = '/Users/dtakeshi/Documents/Data/ParsedSymphonyData';
ctype = 'opn_PP_off_s';
cname = 'LightStep_20_033115Ac6_parsed';
dat0 = load(fullfile(dat_path,ctype,cname));
I = dat0.stimIntensity;
param.binwidth = 10;
param.twindow = 400;%msec
stim_off = 20/1000;
t = -0.5:param.binwidth/1000:0.52;
dat = parseForAnalysis(dat0);
[spc_hist, t] = cellfun(@(s)calcSpikeCountHist(s, param.binwidth), dat,'unif',0);

[idx_pre, idx_post, param] = get_analysis_intervals( t{1}, stim_off, param );
spc_pre = cellfun(@(v)v(:,idx_pre),spc_hist,'unif',0)';
spc_post = cellfun(@(v)v(:,idx_post),spc_hist,'unif',0)';
    % 2AF in the dark
frac_correct = calc2AF_multiple(spc_pre, spc_post)';
semilogx(I,frac_correct)
title(cname,'interpreter','none')
xlabel('Intensity (R*/rod/flash)');ylabel('Fraction of correct choice');
set(gca,'fontsize',20)
