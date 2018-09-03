function out=assign_struct(s,str_fields,value)
    % Add a field to a structure
    % example
    % a.b.c = 'apple';
    % str_fields = 'b.d';
    % Then,
    % a = assign_struct(a,str_fields,'orange');
    % returns:
    % a.b.c = 'apple';
    % a.b.d = 'orange';
    % Related codes: ref_struct, assign_fields
    str_fields=strread(str_fields,'%s','delimiter','.');
    str_fields=str_fields(~cellfun('isempty',str_fields));
    out=subsasgn(s,struct('type','.','subs',str_fields),value);
    %out=subsref(s,struct('type','.','subs',str_fields));
end