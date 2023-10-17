function obj = pcssp_PowerSupplies_obj()
% PCSSP PowerSupplies Module for PFPO-1
% CREATE - Napoli
% Timo Ravensbergen - IO
% Relies on 'SCDDS-core' Object-Oriented backend

obj = pcssp_module('pcssp_PowerSupplies');

%% Timing of the algorithm
obj=obj.settiming(0,1e-3,10.0);

%% Fixed parameters init functions 
obj=obj.addfpinitfcn('pcssp_PowerSupplies_loadfp','PowerSupplies_fp');

%% Tunable parameters structure name
obj=obj.addtunparamstruct('PowerSupplies_tp', @()pcssp_PowerSupplies_loadtp());

%% input and output buses
obj = obj.addbus('',@()pcssp_PowerSupplies_busdef);

%% Tasks

%% Print (optional)
obj.printinfo;

end

