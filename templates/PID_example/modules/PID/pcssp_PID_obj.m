function obj = pcssp_PID_obj(n_input)

% example PCSSP module that implements a simple PID controller

obj = pcssp_module('pcssp_PID');

%% Timing of the algorithm
obj=obj.settiming(0,1e-3,10.0);

%% Fixed parameters init functions 
obj=obj.addfpinitfcn('pcssp_PID_loadfp','pcssp_PID_fp');

%% Tunable parameters structure name
obj=obj.addtunparamstruct('pcssp_PID_tp', @()pcssp_PID_loadtp());


%% Buses
obj = obj.addbus('', @() pcssp_PID_inBus_def(n_input));
obj = obj.addbus('pcssp_PID_outBus', 'pcssp_PID_outBus_def' );

 % function handle that returns cell arays of buses and busnames to be registered
% obj = obj.addbus('',@() pcssp_PID_signal_buses());

%% Tasks

%% Print (optional)
obj.printinfo;

end

