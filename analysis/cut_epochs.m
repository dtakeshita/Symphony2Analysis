function [c1_new, c2_new] = cut_epochs(c1,c2)
    nepochs_all = [cellfun(@(d)size(d,1),c1);cellfun(@(d)size(d,1),c2)];
    nepochs = min(nepochs_all);
    c1_new = cellfun(@(d)d(1:nepochs,:),c1,'unif',0);
    c2_new = cellfun(@(d)d(1:nepochs,:),c2,'unif',0);
end