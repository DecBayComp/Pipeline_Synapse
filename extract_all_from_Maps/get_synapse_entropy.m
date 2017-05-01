function Maps = get_synapse_entropy(Maps, value, factor)


% [x_centre, y_centre, x_start, y_start, densities, XX, YY, II, radius] = set_seed_densities_synapses(Maps);
% factor = 2.;

[x_centre, y_centre, x_start, y_start, densities, XX, YY, radius] = set_seed_densities_multi_synapses(Maps, value);
% [x_centre, y_centre, x_start, y_start, densities, XX, YY, II, radius] = set_seed_densities_synapses(Maps);
% factor = 2.5;

if isempty(x_start)
    
    Maps     = add_one_feature_to_Maps(Maps, []  , 'entropy_main');
    Maps     = add_one_feature_to_Maps(Maps, []  , 'entropy');
    Maps     = add_one_feature_to_Maps(Maps, []  , 'entropy_all');
    
else

    n_start = length(x_start);
    
    for i = 1 : n_start
        [indice_voisins, indice_in] = set_neighbors_in_out_boundaries_synapses(x_start(i), y_start(i),x_centre, y_centre, factor, radius(i), Maps);
        [V,surface ] = set_extract_potential_surface_synapses(Maps,indice_in);
        V            = V - min(V);
        p            = exp(-V)./sum(exp(-V));
        entropy(i)   = -sum(p.*log(p));
    end
    Maps         = add_one_feature_to_Maps(Maps, entropy(Maps(1).Index_main_synapse) , 'entropy_main');
    Maps         = add_one_feature_to_Maps(Maps, entropy , 'entropy');
    
    
    for i       = 1: length(Maps)
        V(i)    = Maps(i).V ;   
    end
    V           = V - min(V);
    p           = exp(-V)./sum(exp(-V));
    entropy_all = -sum(p.*log(p));
    Maps        = add_one_feature_to_Maps(Maps, entropy_all , 'entropy_all');

    
end




% [indice_voisins, indice_in] = set_neighbors_in_out_synapses(x_start, y_start,x_centre, y_centre, factor, radius, Maps);

% plot_local_synapses(Maps, XX, YY,densities, x_start, y_start, factor , radius,indice_voisins);

% [V,surface ] = set_extract_potential_surface_synapses(Maps,indice_in);
% V            = V - min(V);
% p            = exp(-V)./sum(exp(-V));
% entropy      = -sum(p.*log(p));
% 
% Maps         = add_one_feature_to_Maps(Maps, entropy , 'entropy');
% 
% clear V surface p;
% 
% 
% for i       = 1: length(Maps)
%     V(i)    = Maps(i).V ;   
% end
% V           = V- min(V);
% p           = exp(-V)./sum(exp(-V));
% 
% entropy_all = -sum(p.*log(p));
% Maps        = add_one_feature_to_Maps(Maps, entropy_all , 'entropy_all');


end
