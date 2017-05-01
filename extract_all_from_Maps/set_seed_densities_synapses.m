function [x_centre, y_centre, x_start, y_start, densities, XX, YY, II, radius] = set_seed_densities_synapses(Maps)



x = []; y = [];
for i = 1 : length(Maps);
x= [x; Maps(i).x];
y= [y; Maps(i).y];
end


x_centre          = [];
y_centre          = [];
for i = 1 : length(Maps);
    x_centre      = [x_centre; Maps(i).center_x];
    y_centre      = [y_centre; Maps(i).center_y];
end

[densities, XX, YY] = effective_densities(x, y, 0.1);
II = find(densities(:) == max(densities(:)));

max_density   = max(densities(:));
max_density_4 = max_density./4;
low           = 0.1*max_density;


JJ            = densities(:) <= low;
densities(JJ) = 0;

x_start           = XX(II);
y_start           = YY(II);


x                 = XX(:);
y                 = YY(:);

epsilon           = 0.02*max_density;

d                 = sqrt( (x - x_start).^2 + (y - y_start).^2) ;
[d,KK]            = sort(d,'ascend');
densities_ordered = densities(KK);
LL                = find(  (densities_ordered > max_density_4 - epsilon/2 ) & ( densities_ordered < max_density_4 + epsilon/2 ) ); 
radius            = d(LL(1));



end