function cname = str2cname( str )
%Convert a string like 'SPT_011111Ec1.mat' into a cell name '011111Ec1'
%   Detailed explanation goes here
    if nargin == 0
        str = 'SpikeCount_LedPulse10_2018-08-21_Ec1-Parsed';
    end
    pat = '\S*(\d{4}-\d{2}-\d{2}_[A-Z][a-z]\d+)';
    cname = regexp(str, pat, 'tokens');
    cname = cname{1}{1};
end

