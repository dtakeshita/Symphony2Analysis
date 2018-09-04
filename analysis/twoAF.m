function Pc = twoAF(nsp1, nsp2, ctype)
    if strcmpi(ctype,'on')
        Pc = (sum(nsp1==nsp2)*0.5 + sum(nsp2 > nsp1))/length(nsp1);
    elseif strcmpi(ctype,'off')
        Pc = (sum(nsp1==nsp2)*0.5 + sum(nsp2 < nsp1))/length(nsp1);
    end
end