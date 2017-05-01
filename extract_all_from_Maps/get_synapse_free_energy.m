function Maps = get_synapse_free_energy(Maps, value, factor)


% [x_centre, y_centre, x_start, y_start, densities, XX, YY, II, radius] = set_seed_densities_synapses(Maps);
% factor = 2.5;

[x_centre, y_centre, x_start, y_start, densities, XX, YY, radius] = set_seed_densities_multi_synapses(Maps, value);
% [x_centre, y_centre, x_start, y_start, densities, XX, YY, II, radius] = set_seed_densities_synapses(Maps);
% factor = 2.5;

if isempty(x_start)
    
    Maps     = add_one_feature_to_Maps(Maps, []  , 'free_energy_main');
    Maps     = add_one_feature_to_Maps(Maps, []  , 'free_energy');
    Maps     = add_one_feature_to_Maps(Maps, []  , 'free_energy_all');
    
else
    
    n_start = length(x_start);
    
    for i = 1 : n_start
        [indice_voisins, indice_in] = set_neighbors_in_out_boundaries_synapses(x_start(i), y_start(i),x_centre, y_centre, factor, radius(i), Maps);
%         [V,surface ]                = set_extract_potential_surface_synapses(Maps,indice_in);
        [V, surface ]                =  set_extract_potential_global_surface_synapses(Maps,indice_in);
         V    = V - min(V);
%         F(i) = -log( sum(exp(-V)) )- ( -log(length(V)));
         F(i) = -log( sum(exp(-V)) )- ( log(surface));
         F_Null(i) = -log( sum(exp(-V*0.)) )- ( log(surface)) ;
    end
    
    F = F - F_Null;
    
    Maps  = add_one_feature_to_Maps(Maps, F , 'free_energy');
    Maps  = add_one_feature_to_Maps(Maps, F(Maps(1).Index_main_synapse) , 'free_energy_main');
    
    x_tot = [];
    y_tot = [];
    for i = 1: length(Maps)
        V(i) = Maps(i).V ;
        x_tot = [x_tot; Maps(i).x];
        y_tot = [y_tot; Maps(i).y];
    end
    K         = convhull(x_tot    , y_tot );
    surface   = polyarea(x_tot(K) , y_tot(K) );
    V         = V - min(V);
    
%     F_all = -log( sum(exp(-V)) ) + log(length(Maps));
    F_all = -log( sum(exp(-V)) ) - log(surface);
    F_Null_All = -log( sum(exp(-V*0.)) )- ( log(surface)) ;
     F_all =  F_all - F_Null_All;
    Maps  = add_one_feature_to_Maps(Maps,F_all , 'free_energy_all');
    
end



% 
% 
% [indice_voisins, indice_in] = set_neighbors_in_out_synapses(x_start, y_start,x_centre, y_centre, factor, radius, Maps);
% 
% plot_local(Maps, XX, YY,densities, x_start, y_start, factor , radius,indice_voisins);
% 
% [V,surface ] = set_extract_potential_surface_synapses(Maps,indice_in);
% V   = V - min(V);
% 
% F = -log( sum(exp(-V)) )- ( -log(length(V)));
% clear V surface;
% 
% Maps  = add_one_feature_to_Maps(Maps,F , 'free_energy');
% 
% for i = 1: length(Maps)
% V(i) = Maps(i).V ;   
% end
% V = V- min(V);
% 
% F_all = -log( sum(exp(-V)) ) + log(length(Maps));
% 
% Maps  = add_one_feature_to_Maps(Maps,F_all , 'free_energy_all');
% 

end

