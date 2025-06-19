function obj = pcssp_cruise_controller_obj()


obj = pcssp_module('pcssp_cruise_controller');

%% Timing of the algorithm
obj=obj.settiming(0,1e-3,10.0);

%% Fixed parameters init functions 
obj=obj.addfpinitfcn('cruise_controller_load_fp','cruise_controller_fp');

%% Tunable parameters structure name
obj=obj.addtunparamstruct('cruise_controller_tp', @()cruise_controller_load_tp());

end