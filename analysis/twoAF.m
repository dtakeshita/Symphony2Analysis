function Pc = twoAF(nsp1, nsp2)
    Pc = (sum(nsp1==nsp2)*0.5 + sum(nsp2 > nsp1))/length(nsp1);
end