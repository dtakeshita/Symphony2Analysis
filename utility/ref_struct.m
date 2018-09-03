% Obtain a field of a structure
% example
% a.b.c = 'apple';
% str_fields = 'b.c';
% Then,
% out = ref_struct(a,str_fields)
% returns 'apple'
% See also: assign_struct
function out=ref_struct(s,str_fields)
    str_fields=strread(str_fields,'%s','delimiter','.');
    str_fields=str_fields(~cellfun('isempty',str_fields));
    try
        out=subsref(s,struct('type','.','subs',str_fields));
    catch
        out = NaN;
    end
end