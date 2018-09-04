function h = plot_probdist( V,varargin)
%Plot discrte probability distribution
%   Detailed explanation goes here
    if nargin == 0
       close all;
       V = [1 1 1 1 1 1 2 2 2 3 3 4 ];        
    end
    if nargin >=2
        opt = varargin{1};
    else
        opt = 'line';
    end
    [Xdat,Ydat] = get_probdist(V);
    %add "end points"
    X = (Xdat(1)-1):1:(Xdat(end)+2);
    Y = zeros(size(X));
    Y(X>=Xdat(1) & X<=Xdat(end)) = Ydat;
    %h = stairs(X-0.5, Y);
    h = my_stairs(X-0.5, Y,opt);
end

