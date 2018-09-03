function out = my_le( A,B,varargin )
%Smilar to Less than or equal to, but when the numbers are very close even 
%if they are not the same, it will be included, whether its less than B or not
    if nargin==0
        A = [1:9 10+4e-16];
        B = 10;
        out = le(A,B);
    end
    if nargin >=3
        th = varargin{3};
    else
        th = 5*eps;
    end
    include = abs(A-B) < th;
    out = lt(A,B) | include;
end

