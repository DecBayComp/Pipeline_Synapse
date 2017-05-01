function extract_all_from_Maps(i, target_folder,  varargin )

path      = pwd;
files     = subdir(fullfile(pwd, 'Maps*'));
n_files   = length(files);
factor    = 2.0;

value     = 500;
nb_limit  = 1000;
% value     = 1000;

% Maps = Set_potential_stochastic_integral(Maps, lambda, sigma, dt_theo);

% nb_limit  = 400;
 lambda  = 1;
 sigma   = 25e-3;
 dt_theo = 15e-3;


if ischar(i)
     i = str2num(i);
end
if (nargin==2)
    cd(target_folder);
end


% for i = 1 : n_files
if (i<=n_files)    
    
     load(files(i).name); 
        
     try 
         if isfield(Maps, 'lambda')
         else
             Maps = Set_potential_stochastic_integral(Maps, lambda, sigma, dt_theo);
             Maps = add_one_feature_to_Maps(Maps, lambda         , 'lambda');
         end
     end
     
     [Maps] = get_synapse_number_well(Maps, value, factor);
     do_I   = do_i_analyse(Maps,nb_limit);
     Maps   = add_one_feature_to_Maps(Maps, do_I         , 'do_I');
     
     if do_I
         
         Maps   = get_synapse_depth(Maps, value, factor);
         Maps   = get_synapse_diffusivity(Maps, value, factor);
         Maps   = get_synapse_entropy(Maps, value, factor); 
         Maps   = get_synapse_free_energy(Maps, value, factor);
         
     else
         
     end



    close all force;
    save(files(i).name,'Maps');
    
    
end
    
%     load(files(i).name); 
% Maps = get_synapse_depth(Maps); 
% Maps = get_synapse_entropy(Maps); 
% Maps = get_synapse_free_energy(Maps); 
% Maps = get_synapse_diffusivity(Maps); 
% Maps = get_synapse_number_well(Maps);     
%     
% end

%     try load(files(i).name); end
%     try Maps = get_synapse_number_well(Maps, value, factor); end;
%     try Maps = get_synapse_depth(Maps, value, factor); end;
%     try Maps = get_synapse_diffusivity(Maps, value, factor); end;
%     try Maps = get_synapse_entropy(Maps, value, factor); end;
%     try Maps = get_synapse_free_energy(Maps, value, factor); end;









