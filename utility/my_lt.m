function out = my_lt( A,B,varargin )
%Smilar to Less than, but when the number is too close, it will be
%excluded, whether its larger than B or not
%   Detailed explanation goes here
    if nargin==0
        A = [1:9 10-4e-16];
        B = 10;
        out = lt(A,B);
    end
    if nargin >=3
        th = varargin{3};
    else
        th = 5*eps;
    end
    exclude = abs(A-B) < th;
    out = lt(A,B) & ~exclude;
end

