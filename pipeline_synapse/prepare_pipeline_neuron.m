function [path,files, size_pixel,dt_frame_ms, dt_frame, ...
    state, modal,criterion ,zero_num,radius_neuron, ...
    name_pipeline, fixed_mesh,  Previous_Assignment ] = prepare_pipeline_neuron()


%% all parameters for VLP
path              = pwd;
files             = subdir(fullfile(pwd, '*.trxyt'));
size_pixel        = 0.16;
dt_frame_ms       = 15;
dt_frame          = dt_frame_ms/1000;
radius_neuron     = 0.2;
 state             = 'diff_voronoi';
% state             = 'diff_tree';
modal             = 'hungarian';
criterion         = 'number_point_sliding';
%criterion         = 'fixed_duration_sliding';

zero_num          = num2str(0);
name_pipeline     = 'neurons';

if ~exist('fixed_mesh');        fixed_mesh        = []    ; end
if ~exist('name_pipeline');     name_pipeline     = 'main'; end
if ~exist('Previous_Assignment'); Previous_Assignment = []; end




end





