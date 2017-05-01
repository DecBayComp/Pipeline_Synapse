function pipeline_synapse(i, target_folder, varargin)

if ischar(i)
    i = str2num(i);
end
warning('off', 'all');
cd(target_folder);


[path,files, size_pixel,dt_frame_ms, dt_frame, ...
state, modal,criterion ,zero_num,radius_neuron, ...
name_pipeline, initial_mesh,  Previous_Assignment ] = prepare_pipeline_neuron();

n_files = length(files);


if i<= n_files
    [name_folder, filename, inum] = dynamical_folder_and_path_generation_neurons(i, files);

    [receptors, mutation, number_cluster,...
    EXP,drug, state_drug,  vs,name_file ,...
    full_hierarchy_name,dt ] = quick_process_names_neuron_pipeline(files(i).name);
    
    inum               = num2str(i);

    cd(name_folder);
    test               = load(files(i).name);
    [xyt,t_min, t_max] = generate_xyt_neuron(test);
    movie_per_frame    = convert_traj_struct(xyt); 
    [movie_per_frame, ~]  = add_linkability_number_movie_per_frame(movie_per_frame,name_pipeline );
    [Maps]             = Mapping_without_tracking(movie_per_frame,state, ...
        modal,Previous_Assignment,  initial_mesh, name_pipeline);
    nb_tot  = total_number_of_linked_points(movie_per_frame,1, length(movie_per_frame));
    
    [Maps]  = add_features_time_evolving_Maps(Maps,t_min, t_max);
    [Maps]  = add_one_feature_to_Maps(Maps, nb_tot               , 'nb_linked_particles');
    [Maps]  = add_one_feature_to_Maps(Maps, dt                   , 'dt');
    [Maps]  = add_one_feature_to_Maps(Maps, receptors            , 'receptors');
    [Maps]  = add_one_feature_to_Maps(Maps, mutation             , 'mutation');
    [Maps]  = add_one_feature_to_Maps(Maps, number_cluster       , 'number_cluster');
    [Maps]  = add_one_feature_to_Maps(Maps, EXP                  , 'EXP');
    [Maps]  = add_one_feature_to_Maps(Maps, drug                 , 'drug');
    [Maps]  = add_one_feature_to_Maps(Maps, vs                   , 'vs');
    [Maps]  = add_one_feature_to_Maps(Maps, state_drug           , 'state_drug');
    [Maps]  = add_one_feature_to_Maps(Maps, name_file            , 'name_trxyt_file');
    [Maps]  = add_one_feature_to_Maps(Maps, full_hierarchy_name  , 'full_hierarchy_name');

    fprintf('%i\n', length(Maps));
    if (length(Maps)>1)
        save_individual_Mat_file(Maps, inum);
        try
        generate_file_for_pure_optimization(Maps, inum);
        end
        clear Maps;
    end


end


end
