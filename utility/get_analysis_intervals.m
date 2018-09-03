function [ idx_pre, idx_post, param] = get_analysis_intervals( xvalue, stim_duration, param )
%calculate indices for pre & post time intervals for analysis
%xvalue:time vector (sec), stim_duration: stimulus duration (sec)
%param:parameters. twindow:length of time window (msec),
%twindow_offset_pre: offset for pre time window (optional)
%   Detailed explanation goes here
    if nargin == 0;%test purpose
       %param.binwidth = 100;
       param.twindow = 1000;%msec
       param.twindow_offset_post = 1000;%msec
       param.twindow_offset_pre = -3000;%msec
       param.multiplewindows = false;%take average over windows or not
       param.overlap_length = 500;%msec
       stim_duration = 5;%sec
       xvalue = -5:0.1:5;
    end
    v2struct(param);
    %one could use inputperser in the future
    %convert from msec to sec, except for stimulus duration
    twindow = twindow/1000;
    if ~exist('multiplewindows','var')
        multiplewindows = false;%no use of multiple windows
    end
    if exist('overlap_length','var')
        overlap_length = overlap_length/1000;%convert from msec to second
    else
        overlap_length = 0;%no overlap
    end
    if ~exist('twindow_offset_pre','var')
        twindow_offset_pre = 0;
    else
        twindow_offset_pre = twindow_offset_pre/1000;%msec to sec
    end
    if ~exist('twindow_offset_post','var')
        twindow_offset_post = 0;
    else
        twindow_offset_post = twindow_offset_post/1000;%msec to sec
    end
    
    if twindow > stim_duration
        %If window size is larger than stimulus duration (e.g. 20ms flash)
        %then take post window from stimulus offset + twindow_offset_post
        t_st_pre = -twindow + twindow_offset_pre;
        t_st_post = stim_duration+twindow_offset_post;%stimulus offset
        t_ed_stim = xvalue(end);%end of epoch
    else
        %If window size is smaller than stimulus duration (e.g. 5sec step)
        %then take post window from stimulus onset + twindow_offset_post
        t_st_pre = -twindow + twindow_offset_pre;
        t_st_post = twindow_offset_post;%stimulus onset
        t_ed_stim = stim_duration;
    end
    t_ed_pre = t_st_pre + twindow;
    t_ed_post = t_st_post + twindow;
    %% extend to multiple window case (possibly with overlap)
    if multiplewindows
        overlap_offset = twindow - overlap_length;
        t_ed_pre = [t_ed_pre:overlap_offset:0]';
        t_ed_post = [t_ed_post:overlap_offset:t_ed_stim]';
        nwin_pre = length(t_ed_pre);
        nwin_post = length(t_ed_post);
%         if nwin_pre ~= nwin_post
%             error('number of windows should be the same for pre and post!')
%         end
        t_st_pre = t_ed_pre-twindow;
        t_st_post = t_ed_post-twindow;
        idx_pre = cell2mat(arrayfun(@(t0,t1) my_le(t0, xvalue)  & my_lt(xvalue, t1),t_st_pre,t_ed_pre,'uniformoutput',false));
        idx_post = cell2mat(arrayfun(@(t0,t1) my_le(t0, xvalue)  & my_lt(xvalue, t1),t_st_post,t_ed_post,'uniformoutput',false));
    else
        idx_pre =   my_le(t_st_pre, xvalue)  & my_lt(xvalue, t_ed_pre);
        idx_post =  my_le(t_st_post, xvalue)  & my_lt(xvalue, t_ed_post);
    end
    param.interval_pre = [t_st_pre t_ed_pre];
    param.interval_post = [t_st_post t_ed_post];
    param.idx_pre = idx_pre;
    param.idx_post = idx_post;
end



