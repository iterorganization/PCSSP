function obj = pcssp_TF_obj()

%% PCSSP transfer function module object definition

obj = pcssp_module('pcssp_TF');

%% Timing of the algorithm
obj=obj.settiming(0,1e-3,10.0);

%% Fixed parameters init functions 
obj=obj.addfpinitfcn('pcssp_TF_loadfp','pcssp_TF_fp'); % function name, var name

%% Tunable parameters structure name
obj=obj.addtunparamstruct('pcssp_TF_tp', @()pcssp_TF_loadtp());


%% Buses
obj = obj.addbus('pcssp_PID_outBus', 'pcssp_PID_outBus_def' );
obj = obj.addbus('pcssp_TF_outBus', 'pcssp_TF_outBus_def' );

%% link PID refdd for shared bus

% obj = obj.addrefdd('pcssp_PID.sldd');


%% Tasks

end

