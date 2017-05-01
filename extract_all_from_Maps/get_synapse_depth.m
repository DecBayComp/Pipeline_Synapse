function Maps = get_synapse_depth(Maps, value, factor)
    

%[x_centre, y_centre, x_start, y_start, densities, XX, YY, II, radius] = set_seed_densities_synapses(Maps);
[x_centre, y_centre, x_start, y_start, densities, XX, YY, radius] = set_seed_densities_multi_synapses(Maps, value);
% factor = 2.;

%%
if isempty (x_start)
    
    depth = [];
    Maps  = add_one_feature_to_Maps(Maps, depth     , 'depth_main');
    Maps  = add_one_feature_to_Maps(Maps, depth     , 'depth_all');
    Maps  = add_one_feature_to_Maps(Maps,[]         , 'Index_main_synapse');
else

    n_start = length(x_start);

    for i = 1 : n_start

        [indice_voisins, indice_in] = set_neighbors_in_out_boundaries_synapses(x_start(i), y_start(i),x_centre, y_centre, factor, radius(i), Maps);
        [V_max , V_min]             = set_min_max_V_synapses(Maps ,x_start(i),y_start(i),indice_voisins, factor, radius(i));
        depth(i)                    = V_max - V_min;
        clear V_max V_min;


    end
    Maps             = add_one_feature_to_Maps(Maps, max(depth) , 'depth_main');
    Maps             = add_one_feature_to_Maps(Maps, depth      , 'depth_all');
    [max_value ,II ] = sort(depth, 'ascend');
    Maps             = add_one_feature_to_Maps(Maps,II(end)    , 'Index_main_synapse');
    
    

    end

end
% [V_max , V_min] = set_min_max_V_synapses(Maps ,x_start,y_start,indice_voisins, factor, radius);
% Maps  = add_one_feature_to_Maps(Maps, depth , 'depth_main');

% [indice_voisins, indice_in] = set_neighbors_in_out_synapses(x_start, y_start,x_centre, y_centre, factor, radius, Maps);

% plot_local_synapses(Maps, XX, YY,densities, x_start, y_start, factor , radius,indice_voisins);
