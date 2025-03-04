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

 % function handle that returns cell arays of buses and busnames to be registered
obj = obj.addbus('',@() pcssp_TF_signal_buses());

%% Tasks

%% Print (optional)
obj.printinfo;

end

