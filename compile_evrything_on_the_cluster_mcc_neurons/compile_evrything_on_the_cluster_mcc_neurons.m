function compile_evrything_on_the_cluster_mcc_neurons

cd ..;

global_path = pwd;

cd([global_path '/pipeline_synapse']);
system('mcc -m -R -nojvm -R -singleCompThread -v pipeline_synapse.m') ;
cd .. ;

cd([global_path '/collect_all_clusters_files_neurons']);
system('mcc -m -R -nojvm -R -singleCompThread -v collect_all_clusters_files_neurons.m') ;
cd .. ;

cd([global_path '/reload_vmesh_files_neurons_no_parallel']);
system('mcc -m -R -nojvm -R -singleCompThread -v reload_vmesh_files_neurons_no_parallel.m') ;
cd .. ;

cd([global_path '/spread_vmesh_to_origin_files_neurons_no_parallel']);
system('mcc -m -R -nojvm -R -singleCompThread -v spread_vmesh_to_origin_files_neurons_no_parallel.m') ;
cd .. ;

cd([global_path '/extract_all_from_Maps']);
system('mcc -m -R -nojvm -R -singleCompThread -v extract_all_from_Maps.m') ;
cd .. ;


end