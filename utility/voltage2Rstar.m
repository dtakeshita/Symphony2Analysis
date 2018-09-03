function v2Rstr = voltage2Rstar( )
%Correspondance between LED voltage and R*/RGC
%Guessed from Fred's e-mail
    led_vol_set = {0.70, 1.40, 2.1, 2.8, 4.2};
    RstarRGC = [1 2 3 4 6];
    v2Rstr0 = containers.Map(led_vol_set,RstarRGC );
    
    led_vol_set = {0.66, 0.83, 1.16, 1.5, 1.83,...
                   2.32, 2.82, 3.49, 4.15};
    RstarRGC = [8, 10, 14, 18, 22,...
                28, 34, 42, 50];
    v2Rstr1 = containers.Map(led_vol_set,RstarRGC );
    
    v2Rstr = [v2Rstr0; v2Rstr1];
end

