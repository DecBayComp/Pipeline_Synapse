function [Maps, number_well] = get_synapse_number_well(Maps, value, factor)


[~, ~, ~, ~, densities, XX, YY, ~, ~] = set_seed_densities_synapses(Maps);
% factor = 2.5;

% value       = 1000;
[cent]      = FastPeakFind(densities,value );
number_well = round(length(cent)./2);
Maps        = add_one_feature_to_Maps(Maps,number_well , 'number_well');


end

