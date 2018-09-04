close all;
clear;
code_root = '/Users/dtakeshi/Documents/MATLAB/Symphony2Analysis';
addpath(genpath(code_root))
dat_path = '/Users/dtakeshi/Documents/Data/FredPrimateData/parsedFiles';
save_path = '/Users/dtakeshi/analysis/summaryPlots/PreliminaryAnalysis/FredPrimateData';
ctype = 'On';
cname = '2018-08-21_Ec4';
% ctype = 'Off';
% cname = '2018-08-21_Ec3';
%nEpochUsed = 50;%comment this out for all epochs

spt_file = sprintf('LedPulse10_%s-Parsed',cname);
spc_file = sprintf('SpikeCount_LedPulse10_%s-Parsed',cname);
dat_spt = load(fullfile(dat_path,ctype,spt_file));
dat = load(fullfile(dat_path,ctype,spc_file));
pre = dat.s.spc_pre.values;
post = dat.s.spc_post.values;
%% use part of epochs
if exist('nEpochUsed','var')
    pre = cellfun(@(spc)spc(1:nEpochUsed),pre,'unif',0);
    post = cellfun(@(spc)spc(1:nEpochUsed),post,'unif',0);
    dat_spt.spikeTiming = cellfun(@(spc)spc(1:nEpochUsed),dat_spt.spikeTiming,'unif',0);
    ttl_str = sprintf('%s, 1-%d epochs',cname,nEpochUsed);
else
    ttl_str = sprintf('%s, all epochs',cname);
end

%% calculate spike count?
spc_diff = cellfun(@(p0,p1)p1-p0,pre,post,'unif',0);
if strcmpi(ctype,'off')
    spc_diff = cellfun(@(s)-s,spc_diff,'unif',0);
end
spc_pre_mean = cellfun(@mean, pre);
spc_post_mean = cellfun(@mean, post);
spc_diff_mean = cellfun(@mean, spc_diff);
spc_diff_std = cellfun(@std, spc_diff);

%% calc two AF with spike count difference
twoAFs_spcdiff = struct();
twoAFs_spcdiff = calc2AFwithSpikeCountDifference(dat.s.RstarMean, pre, post, twoAFs_spcdiff, ctype );

%% calc two AF with spike counts
twoAFs_spc = struct();
twoAFs_spc = calc2AFwithSpikeCount(dat.s.RstarMean, pre, post, twoAFs_spc, ctype );
%% calc two AF with mean discriminator

%% plotting parameters
ft_sz = 16;

%% Plot Raster
drawRasterPerLightAmplitude(dat_spt)
my_annotation(ttl_str);
%% plot spike count distribution
nfig = length(findobj('type','figure'));
[h,x_lim] = plot_probdistset( spc_diff, dat.s.RstarMean, nfig )

%% plot spike count 
fh_spc = figure;
subplot(2,1,1)
semilogx(dat.s.RstarMean, spc_pre_mean,'x-')
hold on
semilogx(dat.s.RstarMean, spc_post_mean,'o-')
legend({'Pre','Post'})
xlabel('R*/RGC');ylabel('Spike count');
title(ttl_str,'interpreter','none')
subplot(2,1,2)
loglog(dat.s.RstarMean, spc_diff_mean,'o-')
xlabel('R*/RGC');ylabel('Spike count difference');
y_min = 10^floor(min(log10(spc_diff_mean(spc_diff_mean>0))));
y_max = 10^ceil(max(log10(spc_diff_mean(spc_diff_mean>0))));
set(gca,'ylim',[y_min y_max])
ah = findobj(fh_spc,'type','axes');
set(ah,'fontsize',ft_sz);
%% Plotting 2AF curves
nfig = length(findobj('type','figure'));
[fh_twoAF, h_exp] = plot_twoAFs(twoAFs_spc,cname,'Data','k',nfig);
my_annotation(sprintf('%s, 2AF with spike count',cname)) 
% mark 75% threshold in 2AF?

nfig = length(findobj('type','figure'));
[fh_twoAF, h_exp] = plot_twoAFs(twoAFs_spcdiff,cname,'Data','r',nfig);
my_annotation(sprintf('%s, 2AF with spike count DIFFERENCE',cname)) 

% plot dipper
figure;
plot_dipper(twoAFs_spc, 'Data','o','k','-')
hold on
plot_dipper(twoAFs_spcdiff, 'Data','o','r','-')
legend({'Spike count','Spike count difference'})
title(sprintf('%s, Dipper',ttl_str),'interpreter','none')

 %% save figures
sname =sprintf('Dipper_Summary_%s.pdf',cname);
prop = struct();
prop.PaperOrientation = 'Portrait';
setFigureSize([],prop);
save_figs('',sname,save_path,'saveas');
