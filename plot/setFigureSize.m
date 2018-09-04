function hFig = setFigureSize( varargin )
%Set figures for A4 size printing
%   Detailed explanation goes here
    if nargin == 0
        hFig = findobj('type','figure');
    end
    if nargin >=1
        hFig = varargin{1};
        if isempty(hFig); hFig = findobj('type','figure');end;
    end
    if nargin >=2
       prop = varargin{2};
    else
        prop = struct([]);
    end
    if ~isempty(prop)
        v2struct(prop);
    end
    if ~exist('PaperOrientation','var')
        PaperOrientation = 'Portrait';
    end
    if ~exist('X','var')
        %X = 29.6774;
        if strcmpi(PaperOrientation,'portrait')
            X = 20.984;
        else
            
            X = 29.6774;
        end
    end
    if ~exist('Y','var')
        %Y = 20.984;
        if strcmpi(PaperOrientation,'portrait')
            Y = 29.6774;
        else
            Y = 20.984;
        end
    end
    if ~exist('xMargin','var')
       xMargin = 1; %# left/right margins from page borders
    end
    if ~exist('yMargin','var')
       yMargin = 1; %# bottom/top margins from page borders
    end
    
    xSize = X - 2*xMargin;     %# figure size on paper (widht & hieght)
    ySize = Y - 2*yMargin;     %# figure size on paper (widht & hieght)
    set(hFig, 'PaperUnits','centimeters')
    set(hFig, 'PaperSize',[X Y])
    set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
    %set(hFig, 'PaperOrientation',PaperOrientation)

end

