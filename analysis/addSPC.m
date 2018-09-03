function out = addSPC( dat, param, cellName,RstarMean, varargin )
    if nargin >= 5
       idx_used = varargin{1}; 
    end
%     dat0 = load(full_path);
    %dat = parseIntoAnalysis(dat0);
    dat = truncate_epochs(dat, param);
    [spc_hist, t] = cellfun(@(s)calcSpikeCountHist(s, param.binwidth), dat,'unif',0);
    if exist('idx_used','var')
       spc_hist = spc_hist(idx_used);
       t = t(idx_used);
    else
        idx_used = 1:length(spc_hist);
    end
    %~,fname]=fileparts(full_path);
    %FRhist.cellName = dat0.out.cellName;
    out.cellName = cellName;
    out.xvalue = t;
    out.value =  cellfun(@(s)mean(s/(param.binwidth/1000),1),spc_hist,'unif',0);
    stim_off = dat{1}.recordingOffset.value;
    [idx_pre, idx_post, param] = get_analysis_intervals( t{1}, stim_off, param );
    spc_pre = cellfun(@(v)sum(v(:,idx_pre),2),spc_hist,'unif',0);
    spc_post = cellfun(@(v)sum(v(:,idx_post),2),spc_hist,'unif',0);
    spc_diff = cellfun(@(x,y)x-y,spc_post,spc_pre,'unif',0);
    dprime_diff = d_prime(spc_diff);
    
    %store in analysis tree??
    %Store calculate values
    out.RstarMean = RstarMean;
    out.spc_pre.values = spc_pre;
    out.spc_post.values = spc_post;
    %out.spc_diff.values = spc_diff;
    out.dprime_diff = dprime_diff;
    out.param = param;
    % calculate statistics
    out.spc_diff = calc_stat(spc_diff, param);
    out.spc_pre = calc_stat(spc_pre, param);
    out.spc_post = calc_stat(spc_post, param);
end

function s = calc_stat(values, param)
    s.values = values;
    s.mean = cellfun(@mean,s.values);
    s.SD = cellfun(@std,s.values);
    s.N = cellfun(@length,s.values);
    s.SEM = s.mean./sqrt(s.N);
    s.param = param
end