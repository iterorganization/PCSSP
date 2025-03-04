function obj = pcssp_varPID_obj()

%% object definition for variable sized PID module
%
obj = pcssp_module('pcssp_varPID');

%% Timing of the algorithm
obj=obj.settiming(0,1e-3,10.0);

%% Fixed parameters init functions 
obj=obj.addfpinitfcn('pcssp_varPID_loadfp','pcssp_varPID_fp');

%% Tunable parameters structure name
obj=obj.addtunparamstruct('pcssp_varPID_tp', @()pcssp_varPID_loadtp());


%% Buses

obj = obj.addbus('',@() pcssp_varPID_signal_buses());

%% Print (optional)
obj.printinfo;

end

