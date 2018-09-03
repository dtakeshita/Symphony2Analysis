function out = calc2AFdiscriminationWithSpikeCount(RstarMean, spc_post, varargin)
    % 2AF in among different intensities
    if nargin >=3
        out = varargin{1};
    end
    if isrow(spc_post); 
        spc_post = spc_post'; 
    end;
    nIall = numel(spc_post);
    I = cell(1,nIall-1);
    Idiff = I;
    Iref = zeros(1,nIall-1);
    foc = I;
    for nI = 1:nIall-1
        Iidx = nI+1:nIall;
        spc2 = spc_post(Iidx);
        spc1 = repmat(spc_post(nI),[numel(spc2) 1]);
        Iref(nI) = RstarMean(nI);
        Iall = RstarMean(Iidx);
        I{nI} = Iall;
        Idiff{nI} = Iall - Iref(nI);
        [spc1, spc2] = cut_epochs(spc1,spc2);
        foc_tmp = cellfun(@(v1,v2)twoAF(v1,v2),spc1,spc2);
        foc{nI} = foc_tmp';
    end   
    out.twoAF_intensities.fractionCorrectSpikeCount = foc;
    out.twoAF_intensities.Ireference = Iref;
    out.twoAF_intensities.Istimulus = I;
    out.twoAF_intensities.Idifference = Idiff;
end