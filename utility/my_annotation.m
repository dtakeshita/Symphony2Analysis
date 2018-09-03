function h = my_annotation( s, varargin )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    if nargin==0
        close all;
        FH(1) = figure;
        FH(2) = figure;
        s='test_1';
    end
    if nargin == 1
        FH = gcf;
    end
    if nargin == 2
        FH = varargin{1};
    end
    %figure(FH);
    nfig = length(FH);
    h = gobjects(nfig,1);
    for n=1:nfig
        h(n)=annotation(FH(n),'textbox',[.35 .95 .3 .05],'string',s,'linestyle','none',...
        'fontsize',16,'HorizontalAlignment','center','interpreter','none',...
        'fontweight','bold'); 
    end


end

