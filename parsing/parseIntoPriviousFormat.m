function out = parseIntoPriviousFormat( varargin )
%parseIntoPriviousFormat(value1,savefield1,value2,savefield2)
%   Detailed explanation goes here
    if nargin == 0
        dat_path = '/Users/dtakeshi/Documents/Data/FredPrimateData/parsedFiles';
        ctype = 'On';
        cname = 'LedPulse10_2018-08-21_Ec1-Parsed';
        dat = load(fullfile(dat_path,ctype,cname));
        fields = {'spikeTiming_all'};
        values = {dat.spikeTiming};
        
    else
        saveFields = varargin(2:2:nargin);
        values = varargin(1:2:nargin);
    end
    out = cell(size(values{1}));
    for nf=1:length(values)
        value = values{nf};
        saveField = saveFields{nf};
        for n=1:length(out)
           out{n}.(saveField).value = value{n}; 
        end
    end

end

