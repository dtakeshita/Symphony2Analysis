function [fh h_line] = plot_twoAFs( twoAFs, fname, plot_field, clr, varargin )
%plot fraction correct for detection/discrimination task
% plot_field: 'Data' or 'Interpolation' (so far)
%   Detailed explanation goes here

    if nargin >= 5
        fh = varargin{1};
    else
        fh = figure();
    end
    %% plot parameters
    lw = 2;
    mkr_sz = 8;
    %% initialization
    nr_fig = 2; 
    nc_fig = 4;
    root_field = sprintf('discrimination.%s',plot_field);
    discr = ref_struct(twoAFs, root_field);
    n_discr = length(discr.rstarDiff);
    n_crv = 1 + n_discr;%detection & discrimination
    n_per_fig = nr_fig*nc_fig; 
    
    h_line = gobjects(1,n_crv);    
%     colors = distinguishable_colors(n_crv);
%     colors(2,:) = [0 1 0];
%     colors(3,:) = [1 0 0];
    %% plot detection 2AF
    subplot(nr_fig,nc_fig,1); hold on;
    root_field = sprintf('detection.%s.',plot_field);
    xvalue = ref_struct(twoAFs, [root_field, 'rstar']);
    value = ref_struct(twoAFs, [root_field, 'fractionCorrect']);
    h_line(1) = plot(xvalue,value);    
    x_lim = 10.^([min(floor(log10(xvalue))) max(ceil(log10(xvalue)))]);
    set(gca,'xlim',x_lim);
    title({str2cname(fname);'Detection task'})
    %% plot discrimination 2AF
    xvalue = discr.rstarDiff;
    value = discr.fractionCorrect;
    pedestals = discr.rstarPedestal;
    for nd=1:n_discr
        subplot(nr_fig,nc_fig,nd+1); hold on;
        if isempty(xvalue{nd})
            continue;
        end
        h_line(nd+1) = plot(xvalue{nd},value{nd});
        title(sprintf('%.2gR*/RGC pedestal',pedestals(nd)));
        x_lim = 10.^([min(floor(log10(xvalue{nd}))) max(ceil(log10(xvalue{nd})))]);
        if x_lim(1) < x_lim(2)
            set(gca,'xlim',x_lim);
        end
    end
    %% set line colors-differnt color for each panel 
%     arrayfun(@(i)set(h_line(i),'MarkerFaceColor',colors(i,:),...
%         'MarkerEdgeColor',colors(i,:)),1:n_crv);
    %arrayfun(@(i)set(h_interp(i),'Color',colors(i,:)),1:n_crv);
    %% set line styles
    switch plot_field
        case 'Data'
            prop = struct('marker','o','linestyle','-','color',clr,...
                'MarkerSize',mkr_sz, 'MarkerFaceColor',clr,'MarkerEdgeColor',clr);
        case 'Interpolation'
            prop = struct('linestyle','-','linewidth',lw,'Color',clr);
        otherwise
            prop = struct('linestyle','-','linewidth',lw,'Color',clr);
    end
    class_name = arrayfun(@class,h_line,'unif',0);
    if all(strcmpi(class_name,'matlab.graphics.chart.primitive.Line'))
        set(h_line,prop);
    end
    %% set axis styles
    set(findobj(fh,'type','axes'),'xscale','log','fontsize',18,'ytick',0.5:0.1:1);
   
    
end

