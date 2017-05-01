function Maps = get_synapse_diffusivity(Maps, value, factor)


crit = 0.1;
[x_centre, y_centre, x_start, y_start, densities, XX, YY, radius] = set_seed_densities_multi_synapses(Maps, value);
% [x_centre, y_centre, x_start, y_start, densities, XX, YY, II, radius] = set_seed_densities_synapses(Maps);
% factor = 2.5;

if isempty(x_start)
    
    Maps     = add_one_feature_to_Maps(Maps, []  , 'diffusivity_all');
    Maps     = add_one_feature_to_Maps(Maps, []  , 'diffusivity_out_all');
    Maps     = add_one_feature_to_Maps(Maps, []  , 'diffusivity_main');
    Maps     = add_one_feature_to_Maps(Maps, []  , 'diffusivity_out_main');
    Maps     = add_one_feature_to_Maps(Maps, []  , 'diffusivity_relative_variation_all');
    Maps     = add_one_feature_to_Maps(Maps, []  , 'diffusivity_diversity_all');
    
else
    
    n_start = length(x_start); 
    for i =1 : n_start
        
%         [indice_voisins, indice_in] = set_neighbors_in_out_synapses(x_start(i), y_start(i),x_centre, y_centre, factor, radius(i), Maps);
        [indice_voisins, indice_in] = set_neighbors_in_out_boundaries_synapses(x_start(i), y_start(i),x_centre, y_centre, factor, radius(i), Maps);
        indice = 1 ;
        for j =1 : length(indice_in)
            diffusivity (indice,1) = Maps(indice_in(j)).D;
            indice = indice + 1;
        end
        diffusivity             = sort(diffusivity);
        diffusivity_synapse(i)  = mean( diffusivity(1: max(1, floor(crit*length(diffusivity))))  );
        
        
        indice = 1 ;
        for j =1 : length(indice_voisins)
            diffusivity_out(indice,1) = Maps(indice_voisins(j)).D;
            indice = indice + 1;
        end
        diffusivity_out_synapse(i)      = mean( diffusivity_out  );
        
        relative_variation_diffusion(i) = (diffusivity_out_synapse(i) - diffusivity_synapse(i)  )./ diffusivity_out_synapse(i); 
               
    end
    
    Maps                 = add_one_feature_to_Maps(Maps, diffusivity_synapse            , 'diffusivity_all');
    Maps                 = add_one_feature_to_Maps(Maps, diffusivity_out_synapse        , 'diffusivity_out_all');
    Maps                 = add_one_feature_to_Maps(Maps, diffusivity_synapse(Maps(1).Index_main_synapse)       , 'diffusivity_main');
    Maps                 = add_one_feature_to_Maps(Maps, mean( diffusivity_out_synapse) , 'diffusivity_out_main');
    Maps                 = add_one_feature_to_Maps(Maps, relative_variation_diffusion   , 'diffusivity_relative_variation_all');
    
    
    diffusion = [];
    for j = 1 : length(Maps)
        diffusion      = [diffusion ;Maps(j).D ] ;
    end

    Diffusion_std_mean = std(diffusion)./mean(diffusion) ;
    Maps               = add_one_feature_to_Maps(Maps, Diffusion_std_mean , 'diffusivity_diversity_all');
    
    
    
end

%     Maps                 = add_one_feature_to_Maps(Maps, min(diffusivity_synapse)       , 'diffusivity_main');
%     

% [indice_voisins, indice_in] = set_neighbors_in_out_synapses(x_start, y_start,x_centre, y_centre, factor, radius, Maps);

%  indice = 1 ;
% for j =1 : length(indice_in)
%     diffusivity (indice,1) = Maps(indice_in(j)).D;
%     indice = indice + 1;
% end


% diffusivity         = sort(diffusivity);
% diffusivity_synapse = mean( diffusivity(1: max(1, floor(crit*length(diffusivity))))  );
% 
% 
% 
% Maps  = add_one_feature_to_Maps(Maps, diffusivity_synapse , 'diffusivity_main');

diffusion = [];
for j = 1 : length(Maps)
   diffusion = [diffusion ;Maps(j).D ] ;
end

Diffusion_std_mean = std(diffusion)./mean(diffusion) ;
Maps  = add_one_feature_to_Maps(Maps, Diffusion_std_mean , 'diffusivity_diversity_all');



end






