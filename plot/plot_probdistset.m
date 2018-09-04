function [h,x_lim] = plot_probdistset( V, Rstr,varargin )
%Plot a set of discrte probability distributions
%   Detailed explanation goes here
    if nargin == 0
       close all;
       V1 = [1 1 1 1 1 1 2 2 2 3 3 4 ];
       V2 = V1 + 2;
       V = {V1, V2};
       FH_offset = 0;
    end
    if nargin == 2
        FH_offset = 0;
    end
    if nargin >= 3
        FH_offset = varargin{1};
    end
    [Xdat,Ydat] = cellfun(@get_probdist,V,'unif',0);
    Xmin = min(cellfun(@min,Xdat));
    Xmax = max(cellfun(@max,Xdat));
    %add "end points"
    ndat = length(Ydat);
    X = (Xmin-1):1:(Xmax+2);
    for nd = 1:ndat
        y_tmp = zeros(size(X));
        tmp = Ydat{nd};
        if isrow(tmp)
            tmp = tmp';
        end
        y_tmp(X>=Xdat{nd}(1) & X<=Xdat{nd}(end)) = tmp;
        Y{nd} = y_tmp;
    end
    nr_fig = 3; 
    nc_fig = 3;
    n_per_fig = nr_fig*nc_fig; 
    n_fig_total = ceil(ndat/n_per_fig);
    FH = gobjects(1,n_fig_total);
    for n=1:n_fig_total
        FH(n) = figure(n+FH_offset);
    end
    
    for nd = 1:ndat
        n_fig = ceil(nd/n_per_fig);
        %figure(n_fig+FH_offset);
        figure(FH(n_fig));
        subplot(nr_fig,nc_fig,nd-(n_fig-1)*n_per_fig); 
        h = bar(X,Y{nd});
        ttl_str = sprintf('%d R*/RGC',Rstr(nd));
        title(ttl_str);
    end
    
    x_lim = [Xmin Xmax];
end

