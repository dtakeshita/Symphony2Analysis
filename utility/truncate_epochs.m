function dat = truncate_epochs(dat, param)
    if ~isfield(param,'n_epochs')
        return;
    end
    ndat = length(dat);
    for nd=1:ndat
        spt = dat{nd}.spikeTimes_all.value;
        if param.n_epochs < length(spt)
           dat{nd}.spikeTimes_all.value = spt(1:param.n_epochs);
        end
        
    end
end