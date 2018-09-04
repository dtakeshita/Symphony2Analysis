function drawRasterPerLightAmplitude(dat)
    if nargin == 0
        close all;
        dat_path = '/Users/dtakeshi/Documents/Data/FredPrimateData/parsedFiles';
        ctype = 'Off';
        cname = 'LedPulse10_2018-08-21_Ec3-Parsed';
        dat = load(fullfile(dat_path,ctype,cname));
        %dat = load(fullfile(dat_path,cname));
    end

    recOnset = -0.5;
    recOffset = 0.5;
    LineFormat.color = 'k';
    FH = figure;
    nInt = length(dat.spikeTiming);
    for nI = 1:nInt
        spt = dat.spikeTiming{nI};
        FR = cellfun(@(spt)length(spt>-0.4 & spt<0),spt)/0.4;
        FR_mean = mean(FR);
        FR_var = var(FR);
        subplot(ceil(nInt/2),2,nI)
        plotSpikeRaster(spt,...
                            'PlotType','vertline','LineFormat',LineFormat,...
                            'VertSpikeHeight',0.8,'XLimForCell',...
                            [recOnset recOffset],'FigHandle',FH);
        ttl_str = sprintf('%.3g R*/RGC, FR mean:%.1f Hz, var:%.1f',...
            dat.RstrRGC(nI), FR_mean, FR_var)
        title(ttl_str)
    end
    %my_annotation(cname)
end