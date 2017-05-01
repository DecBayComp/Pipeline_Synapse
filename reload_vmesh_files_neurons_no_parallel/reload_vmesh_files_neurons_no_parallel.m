function reload_vmesh_files_neurons_no_parallel(target_folder, varargin)
%% call clear;reload_vmesh_files(1,343,[]);
warning off;

cd(target_folder);


files           = subdir(fullfile(pwd, 'Maps*'));
function_load   = @load_vmesh_to_Maps;
function_path   = @extract_path_from_full_name;
function_number = @get_number_from_Maps_files;

for i = 1 : length(files);
%     fprintf('%i\n', i);
    try
    name            = files(i).name;
    path            = feval(function_path, name);
    number          = feval(function_number, name);
    number_num      = num2str(number);
    
    if ismac || isunix
        full_name_vmesh = [path '/' number_num '.vmesh'] ;
    elseif ispc
        full_name_vmesh = [path '\' number_num '.vmesh'];
    end

    feval(function_load, name, full_name_vmesh);
    end
end
