function [spc_hist, t] = calcSpikeCountHist(node, binwidth)
    %Note: In spike timings, 0 corresponds to the stimulus onset 
    %caluclated in getEpochResponses_CA_PAL)
    binwidth = binwidth/1000;%convert to sec
    spt_set = node.spikeTimes_all.value;
    rec_on =  node.recordingOnset.value;
    rec_off = node.recordingOffset.value;
    %t = rec_on:binwidth:rec_off;
    t_right = 0:binwidth:rec_off;
    t_left = -binwidth:-binwidth:rec_on;
    t = [t_left(end:-1:1) t_right];
    spc_set = cellfun(@(spt)hist(spt,t),spt_set,'UniformOutput',false);
    spc_hist = cell2mat(spc_set');
    %test purpose
%     figure;
%     plot(t,mean(spc_hist,1))
%     title(node.name)
%     2;
end