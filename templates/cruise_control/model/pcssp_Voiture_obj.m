function obj = pcssp_Voiture_obj()

% example PCSSP module that implements a simple PID controller

obj = pcssp_module('pcssp_Voiture');

%% Timing of the algorithm
obj=obj.settiming(0,1e-3,10.0);

%% Fixed parameters init functions 
obj=obj.addfpinitfcn('pcssp_Voiture_loadfp','pcssp_Voiture_fp');

%% Tunable parameters structure name
obj=obj.addtunparamstruct('pcssp_Voiture_tp', @()pcssp_Voiture_loadtp());


%% Buses
obj = obj.addbus('', @() pcssp_Voiture_inBus_def());
obj = obj.addbus('', @() pcssp_Voiture_outBus_def());

end

