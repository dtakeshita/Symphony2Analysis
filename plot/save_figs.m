% save_figs({FHs, sname, save_path})
function save_figs( varargin )
    if nargin >=1
        FHs = varargin{1};
        if isempty(FHs)
            FHs = findobj('type','figure'); 
        end
    else
        FHs =findobj('type','figure');
    end
    if nargin >=2
        sname = varargin{2};
    else
        sname = 'savedfigures';
    end
    if nargin >=3
        save_path = varargin{3};
    else
       save_path = cd;
    end
    if nargin >=4
        save_func = varargin{4};
    else
        save_func = 'export_fig';
    end
    if isempty(FHs)
        msg =[sname,':no figures'];
        display(msg);
       return; 
    end
    if any(strcmp(fieldnames(FHs(1)),'Number')) && iscell(get(FHs,'Number'))%R2014b && multiple figures
            [~,idx]=sort(cell2mat(get(FHs,'Number')));
            FHs = FHs(idx);
    else
        FHs = sort(FHs);
    end
    if ~exist(save_path,'dir');
        mkdir(save_path);
    end
    cd(save_path)
    %% remove existing files
    %recycle(sname);%This is for Windows. One can know what OS it is...
    recycle('on');%For Mac. Does this work for Windows as well??
    sname = rm_ext(sname);
    sname_pdf = [sname,'.pdf'];
    if exist(sname_pdf,'file')
        delete(sname_pdf)
    end
    %% make a directory for fig files
    matfig_path = fullfile(save_path,'figfile');
    if ~exist(matfig_path,'dir')
       mkdir(matfig_path);
    end
    %% Save figures
    nfig = length(FHs);
    sname_list=cell(nfig,1);
    for n=1:nfig
        %figure(FHs(n));
        %Save as fig file as well
        sname_fig = [sname,'_',num2str(n),'.fig'];
        try
            saveas(FHs(n),fullfile(matfig_path, sname_fig),'fig');
            %Then save as pdf
            sname_tmp = ['tmp',num2str(n),'.pdf'];
            set(FHs(n),'color',[1 1 1],'visible','off')
            if strcmp(save_func, 'export_fig')
                %eval(['export_fig ',sname_tmp,' -pdf']);
                export_fig(sname_tmp,'-pdf',FHs(n));
            elseif strcmp(save_func,'saveas')
                saveas(FHs(n),sname_tmp,'pdf');
            end
            sname_list{n}=sname_tmp;
        catch err
            str_err = sprintf('Fig%d: error%s, %s',FHs(n).Number, err.identifier, err.message);
           display( str_err);
        end
    end
    if ~strcmpi(sname(end-3:end),'.pdf')
        sname = [sname,'.pdf'];
    end
    append_pdfs(sname,sname_list{:})
    delete(sname_list{:})
    close all;
    %eval(['winopen ',sname])
    %eval(sprintf('system([''open '',%s''])',sname));
end

