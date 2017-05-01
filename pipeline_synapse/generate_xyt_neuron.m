function [xyt,t_min, t_max] = generate_xyt_neuron(test)


trajs    = test;
xyt(:,1) = trajs(:,2);
xyt(:,2) = trajs(:,3);
xyt(:,3) = trajs(:,4);
t_min    = min(xyt(:,3));
t_max    = max(xyt(:,3));
