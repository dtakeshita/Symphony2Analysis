function [ output_args ] = calculateSpikeCount( )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    close all;
    dat_dir = '/Users/dtakeshi/Documents/Data/FredPrimateData/parsedFiles';
    save_dir = '';
    %fname = 'test_spiketime.mat';    
     param.binwidth = 10;
%     param.n_epoch_min = 10;%minimum # of trials required
%     param.binwidth = 10;%Bin size for spike count histogram (in msec)
%     param.smoothingWindow = 100;%smoothing window (in msec)
    param.twindow = 490;%msec
    
%     fig_para = param_tilefigs();
%     fig_para.nrow = 3; fig_para.ncol = 2;
%     fig_para.visible = 'on';
    %ctypes = {'OFF','ON'};
    ctype = 'ON';
    
    [files, pathname] = uigetfile(fullfile(dat_dir,ctype,...
        '*.mat'), 'Pick MAT files','MultiSelect','On');
    if ~iscell(files); files = {files}; end;
    %% Should check if spike count files already exists!!!
    
    for nf=1:length(files)
        out = calcSPC_primate( fullfile(pathname,files{nf}), param );
        if length(out.RstarMean) == length(out.value)
%             figure;
%             plotSPCdiff_eachCell(out, ctype);
            saveData(out, ctype, save_dir)
        else
           display(sprintf('%s:%s','Length mistmatch:',out.cellName));
        end
    end

end
function saveData(s, cType, save_dir)
    full_path = fullfile(save_dir, cType);
    fname = ['SpikeCount_',s.cellName,'.mat'];
    save(fullfile(full_path, fname), 's');
end

function plot2AFdark_eachCell(s, cType)
    x = s.twoAF_dark.RstarMean;
    y = s.twoAF_dark.fractionCorrect;
    %h = errorbar(x,y,e);
    plot(x,y,'o-')
    %set(gca,'xscale','log','yscale','log')
    str_ttl = sprintf('%s %s twoAFC in dark',cType, s.cellName);
    title(str_ttl)

end

function plotSPCdiff_eachCell(s, cType)
    x = s.RstarMean;
    y = s.spc_diff.mean;
    e = s.spc_diff.SEM;
    v = s.spc_diff.SD.^2;
    subplot(1,3,1)
    h = errorbar(x,y,e);
    set(gca,'xscale','log','yscale','log')
    str_ttl = sprintf('%s %s',cType, s.cellName);
    title(str_ttl)
    subplot(1,3,2)
    plot(4000*x,y,'kx-')
    hold on
    plot(4000*x,v,'r-x')
    legend('Mean','Variance')
    subplot(1,3,3)
    fano = v./y;
    plot(x, fano,'-x')

end


