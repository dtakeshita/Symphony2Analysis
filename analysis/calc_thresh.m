function [out, slope] = calc_thresh(x,y,th)
    %Calculate x-value that would give th using interpolation
    if nargin == 0
        x = 1.0e+04 *[0.0197 0.0396 0.0464 0.1591 0.3728 0.7622 1.4374];
        y = [0.5167 0.7500 0.7500 1.0000 1.0000 1.0000 1.0000];
        th = 0.75;
    end
    if all(y>th) || numel(y) <= 1
        slope = NaN;
        out = NaN;
        return;
    elseif y(1)>y(2)
        x = x(2:end);
        y = y(2:end);
    end
    idx_above = find(y>th,1,'first');
    if ~isempty(idx_above)
        idx_below = find(find(y<th)<idx_above,1,'last');
    else
        idx_below = NaN;
    end
    y_new = y(idx_below:idx_above);
    x_new = x(idx_below:idx_above);
    if length(y_new) < 2
        out = NaN;
        slope = NaN;
        return;
    end
    if any(y_new == th)
        out = mean(x_new(y_new == th));
        slope = NaN;
        return;
    end
    try
        out = interp1(y(idx_below:idx_above),x(idx_below:idx_above),th);
        slope = ( y(idx_above(1))-y(idx_below(end)) )./( x(idx_above(1))-x(idx_below(end)) ); 
    catch
        out = NaN;%If interpolation doesn't work, something is wrong anyway.
        slope = NaN;
    end
end

