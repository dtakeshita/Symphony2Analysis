clear;
%% needs
%% tbUseProject('sa-labs-analysis')
%% cd /Users/dtakeshi/Documents/MATLAB/Symphony2Analysis
%% addpath(genpath(pwd))
dat_path = '/Users/dtakeshi/data/analysis/cellData';
save_path = '/Users/dtakeshi/Documents/Data/FredPrimateData/parsedFiles';
cname = '2018-08-21_Ec3';
cdat = load(fullfile(dat_path,cname));
cdat = cdat.cellData;
nEpochs = cdat.attributes('Nepochs');
stimTimes = arrayfun(@(e)e.get('stimTime'),cdat.epochs);
stimTime = unique(stimTimes);
if length(stimTime)>1
    error('more than one stimulus type');
end
spt = cell(1,nEpochs);
rec_onset = zeros(1,nEpochs);
rec_offset = rec_onset;
for ep=1:nEpochs
    spt_tmp = cdat.epochs(ep).derivedAttributes('Amp1_spikeTimes');
    Fs = cdat.epochs(ep).attributes('sampleRate');
    preTime = cdat.epochs(ep).attributes('preTime');
    tailTime = cdat.epochs(ep).attributes('preTime');
    % pre
    rec_onset(ep) = -(preTime/1000 - 1/Fs);
    rec_offset(ep) = tailTime/1000;
    spt{ep} = -(preTime/1000 - spt_tmp/Fs);
end
if length(unique(rec_onset)) > 1
    error('rec_onset not equal')
end
if length(unique(rec_offset)) > 1
    error('rec_offset not equal')
end
epochVec = 1:nEpochs;
lightAmplitudes = arrayfun(@(e)e.get('lightAmplitude'),cdat.epochs);
lightAmplitude = unique(lightAmplitudes);
%% R* conversion
v2Rstr = voltage2Rstar();
RstrRGCs = arrayfun(@(v)v2Rstr(v), lightAmplitudes);
RstrRGC = unique(RstrRGCs);

%hasAmp = arrayfun(@(amp)lightAmplitudes == amp, lightAmplitude,'unif',0);
hasAmp = arrayfun(@(amp)RstrRGCs == amp, RstrRGC,'unif',0);
spikeTiming = cellfun(@(bl)spt(bl),hasAmp,'unif',0);
dividedEpochs = cellfun(@(bl)epochVec(bl),hasAmp,'unif',0);
recOnset = cellfun(@(bl)unique(rec_onset(bl)),hasAmp,'unif',0);
recOffset = cellfun(@(bl)unique(rec_offset(bl)),hasAmp,'unif',0);
%% save as a mat file
sname = sprintf('LedPulse%d_%s-Parsed.mat',stimTime,cname);
save(fullfile(save_path, sname),'spikeTiming','dividedEpochs',...
    'lightAmplitude','RstrRGC');
%% Add spike count and parse into each intensity - add spike timing...
out = parseIntoPriviousFormat( spikeTiming, 'spikeTimes_all',...
    dividedEpochs,'epochs',recOnset,'recordingOnset',recOffset,'recordingOffset');
param = struct('n_epochs',100,'binwidth',10,'twindow',400);
s = addSPC( out, param, cname, RstrRGC);
% two AF
% pre = s.spc_pre.values;
% post = s.spc_post.values;
% twoAFs_exp = calc2AFwithSpikeCount(RstarMean, pre, post );

%sname = sprintf('LedPulse%d_%s-Parsed.mat',stimTime,cname);
sname = sprintf('SpikeCount_LedPulse%d_%s-Parsed.mat',stimTime,cname);
save(fullfile(save_path, sname),'s')

%spikeTiming;
%lightAmplitude;
