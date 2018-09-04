%rm_ext(s,'stk') where s is such as 'Jan17_3.stk'
% See also get_ext, add_ext, rm_sp
function s=rm_ext(s,varargin)
if nargin>=2
    ext=varargin{1};
    ind=findstr(s,ext);
    s=s(1:ind-2);
else
    ind=findstr(s,'.');
    if ~isempty(ind)
        s=s(1:ind-1);
    end
end
        