function [name_folder, filename, inum] = dynamical_folder_and_path_generation_neurons(i, files)


inum = num2str(i);
name   = files(i).name;


if ismac||isunix
    kkk    = strfind(name, '/'); 
elseif ispc
    kkk    = strfind(name, '\');  
end

name_folder = files(i).name(1:kkk(end)-1);
filename    = name(kkk(end)+1:end);

end