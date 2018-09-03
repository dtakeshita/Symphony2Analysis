function out = calcAFtheshold(I,Pc,Pth)
% Calculate threhold of percent correct curve like
% two-alternative-forced-choice task
    %% threshold calculation
    out = 10^calc_thresh(log10(I),Pc,Pth);
end

