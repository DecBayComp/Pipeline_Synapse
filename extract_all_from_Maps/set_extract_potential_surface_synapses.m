function [V,surface ] = set_extract_potential_surface_synapses(Maps,indice_in)

V = [];
surface = [];

for i =1 : length(indice_in)

V = [V; Maps(indice_in(i)).V];
surface = [surface; Maps(indice_in(i)).surface];


end


end