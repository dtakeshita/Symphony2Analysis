function h = plot_dipper(x,name,mkr,varargin)
% example:
% plot_dipper(dipper, 'Interpolation','x'{,'r','-','log',mkr_sz,clr_dark,I_dark})
    if nargin >= 4
        clr = varargin{1};
    else
        clr = '';
    end
    if nargin >= 5
        linestyle = varargin{2};
    else
        linestyle = 'none';
    end
    if nargin >= 6
        scale = varargin{3};
    else
        scale = 'linear';
    end
    if nargin >= 7
        mkr_sz = varargin{4};
    else
        mkr_sz = 8;
    end
    if nargin >= 8
        clr_dark = varargin{5};
    else
        clr_dark = clr;
    end
    if nargin >= 9
        I_dark = varargin{6};
    else
        I_dark = [];
    end
    
 
    Idetec = 0;
    Idiscr = ref_struct(x.dipper,[name,'.Iref']);
    if strcmpi(scale,'linear')
        I = [Idetec Idiscr];
    elseif isempty(I_dark)
        I = ref_struct(x.dipper,[name,'.Iplot']);
    else
        I = [I_dark Idiscr];
    end
    th = ref_struct(x.dipper,[name,'.th75']);
    n_plot = size(th,1);
    if  n_plot == 1
        h = plot_individual(I,th,mkr,clr,mkr_sz,clr_dark,linestyle);
        hold on
    else
        hold on;
        for np =1:n_plot
            notNan = ~isnan(th(np,:));
            th_tmp = th(np,notNan);
            I_tmp = I(notNan);
            h = plot_individual(I_tmp,th_tmp,mkr,clr,mkr_sz,clr_dark,linestyle);
        end
    end
    %set(h,'linestyle',linestyle);
    set(gca,'xscale',scale,'yscale',scale','fontsize',18)
    xlabel('Pedestal I (R*/RGC)'); ylabel('Thr \Delta I (R*/RGC)');
    if strcmpi(scale,'log') && any(~isnan(th(:)))
        y_lim = 10.^[min(floor(log10(th(:)))) max(ceil(log10(th(:))))];
        set(gca,'ylim',y_lim);
    end
end

function [h_line,h_dark] = plot_individual(I,th,mkr,clr,mkr_sz, clr_dark,linestyle)
    if isempty(clr)
        h = plot(I,th,mkr)
        set(h,'markersize',mkr_sz);
        h_line = h;
        return
    end
    h_dark = gobjects();
    h_left = gobjects();
    h_right = gobjects();
    if ~strcmpi(clr,clr_dark) && ~isempty(clr_dark)
       I_mid = geomean(I(1:2));
       r = 0.8*I_mid/I(1);
       I_left = [I(1) r*I(1)];
       I_right = [I(2)/r I(2)];
       th_left = 10.^interp1(log10(I(1:2)),log10(th(1:2)),log10(I_left));
       th_right = 10.^interp1(log10(I(1:2)),log10(th(1:2)),log10(I_right));
       h_left = plot(I_left, th_left);
       hold on
       h_dark = plot(I(1),th(1));
       
       h_right = plot(I_right, th_right);
       set(h_left,'color',clr_dark);
       set(h_dark,'marker',mkr,'markerFaceColor',clr_dark,...
           'markerEdgeColor',clr_dark,'markersize',mkr_sz);
       set(h_right,'color',clr);
       I = I(2:end);%discrimination tasks
       th = th(2:end);
       h = plot(I,th);
       set(h,'marker',mkr,'markerFaceColor',clr,'markerEdgeColor',clr,...
        'color',clr,'markersize',mkr_sz);
       set([h h_left h_right],'linestyle',linestyle);
       h_line = [h h_left h_right];
       return;
    end
    h = plot(I,th);
    hold on
    set(h,'marker',mkr,'markerFaceColor',clr,'markerEdgeColor',clr,...
        'color',clr,'markersize',mkr_sz);
    h_line = h;
end
