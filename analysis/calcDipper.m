function s = calcDipper( s, name, Pth )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    % detection thredhold
    detect_field = sprintf('detection.%s',name);
    detection = ref_struct(s,detect_field);
    th_detect = calcAFtheshold(detection.rstar, detection.fractionCorrect, Pth);
    % discrimination threshold
    discr_field = sprintf('discrimination.%s',name);
    discr = ref_struct(s,discr_field);
    th_discr = cellfun(@(d,Pc)calcAFtheshold(d,Pc,Pth),discr.rstarDiff,...
                discr.fractionCorrect);
    % parse data
    th = [th_detect th_discr];
    th_name = sprintf('th%d',round(Pth*100));
    Iref = discr.rstarPedestal;%pedestal intensities for discrimination task
    Idark_plot = 10^floor(log10(Iref(1)));%intensity for dark for plotting purpose
    Iplot = [Idark_plot Iref];
    Iref_all = [0 Iref];%pedestal intensities for detection & discr. tasks
    dipper = struct(th_name,th,'Iref',Iref,'Iplot',Iplot,'Iref_all',Iref_all);
    save_field = sprintf('dipper.%s',name);
    s = assign_struct(s,save_field,dipper);
end

