function do_I = do_i_analyse(Maps,nb_limit)

%%
n_Maps       = length(Maps);
x_tot        = [];
for i = 1 : n_Maps
    x_tot    = [x_tot; Maps(i).x];
end
n_tot        = length(x_tot);

number_well  = Maps(1).number_well;


%%
is_well      = number_well>0;
is_potential = isfield(Maps, 'V');
is_number    = n_tot>=nb_limit;

%%
do_I = is_well & is_potential & is_number ;






end