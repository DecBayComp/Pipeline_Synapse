function [receptors, mutation, number_cluster,...
    EXP,drug, state_drug,  vs,name_file ,...
    full_hierarchy_name,dt ] = quick_process_names_neuron_pipeline(name)


full_hierarchy_name = name;
k                   = strfind(name,'/');
k                   = k(end);
name2               = name(k(end)+1:end);
name_file           = name2;

receptors           = give_receptors(name);
dt                  = give_time(name);
number_cluster      = give_number_cluster(name);
mutation            = give_mutation(name_file);
EXP                 = give_EXP(name_file);
[drug, state_drug]  = give_drug(name_file);
vs                  = give_vs(name);



end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function receptors          = give_receptors(name)

j                 = strfind(name, 'FULL-BETA');
if ~isempty(j)
    receptors = 'FULL-BETA';
else
    receptors = 'BETA';
end





end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dt                 = give_time(name)

j                 = strfind(name, 'ms');
dt                = str2num(name(j-2:j-1));

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function number_cluster     = give_number_cluster(name)

j                 = strfind(name, 'cluster'); 
number_cluster    = str2num(name(j+8:j+10));

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function mutation           = give_mutation(name_file)

name_list_mutation = {'WT', '400AA','S403D','S403A', ...
    'Y413D','Y413F', 'TMD', 'S403AY413F','S403AY413D', ...
    };

for j = 1 : length(name_list_mutation)
    k = strfind(name_file , name_list_mutation{j} );
    if ( ~isempty(k)  )
        if length(k)>1
            mutation = name_list_mutation{j};
            break;
        else
            mutation = name_list_mutation{j};
        end
    end

end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function EXP                = give_EXP(name_file)

j                 = strfind(name_file, 'EXP');
EXP               = str2num(name_file(j+3:j+4));

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [drug, state_drug] = give_drug(name_file)

liste_drug = {'PP2', 'PMA'};

j1 = strfind(name_file,'PRE' );
j2 = strfind(name_file,'POST' );

if ~isempty(j1)||~isempty(j2)

    if ~isempty(j1)
        state_drug = 'PRE';
    else
        state_drug = 'POST';
    end
    
    for j = 1 : length(liste_drug)
        k = strfind(name_file,liste_drug{j} );
        if ~isempty(k)
           drug =  liste_drug{j};
           break;
        end
    end
        
else
    drug       = 'no_drug';
    state_drug = 'not_applicable';
end
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [vs]               = give_vs(name)

j     = strfind(name, '-vs-');
if isempty(j)
   vs{1,1} = 'no_vs';
   vs{2,1} = 'no_vs';
else
    
    j        = j(1);
    k        = strfind(name, '/');
    JJ       = find(k>j);
    k_end    = k(min(JJ));
    JJ       = find(k<j);
    k_init   = k(max(JJ));
    name_loc = name(k_init:k_end);
       
    j        = strfind(name_loc, '++');
    vs{1,1}    = name_loc(j(1)+2:j(2)-1); 
    j        = strfind(name_loc, '=');
    vs{2,1}    = name_loc(j(1)+1:j(2)-1); 

end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
