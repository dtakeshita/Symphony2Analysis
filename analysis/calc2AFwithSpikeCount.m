function out = calc2AFwithSpikeCount(I, Pre, Post, varargin )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    if nargin == 4
        out = varargin{1};
    else
        out = struct();
    end
    if nargin == 5
        ctype = varargin{2};
    else
        ctype = 'on';
    end
    %% detection task
    Pc= cellfun(@(v1,v2)twoAF(v1,v2,ctype),Pre,Post)';
    out.detection.Data.rstar = I;
    out.detection.Data.fractionCorrect = Pc;
    %% discrimination task
    discr = struct();
    discr = calc2AFdiscriminationWithSpikeCount(I, Post, discr, ctype);
    % re-parse data for consistency 
    out.discrimination.Data.rstarPedestal = discr.twoAF_intensities.Ireference;
    out.discrimination.Data.rstarDiff = discr.twoAF_intensities.Idifference;
    out.discrimination.Data.fractionCorrect = ...
                          discr.twoAF_intensities.fractionCorrectSpikeCount;
    out = calcDipper(out,'Data',0.75);
end

