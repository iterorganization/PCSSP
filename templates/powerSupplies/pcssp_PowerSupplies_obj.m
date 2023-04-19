function obj = pcssp_PowerSupplies_obj()
% PCSSP PowerSupplies Module for PFPO-1
% CREATE - Napoli
% Timo Ravensbergen - IO
% Relies on 'SCDDS-core' Object-Oriented backend

obj = pcssp_module('pcssp_PowerSupplies');

%% Timing of the algorithm
obj=obj.settiming(0,1e-3,10.0);

%% Fixed parameters init functions 
obj=obj.addfpinitfcn('pcssp_PowerSupplies_loadfp','PS_fp');

%% Tunable parameters structure name
obj=obj.addtunparamstruct('PS_tp', @()pcssp_PowerSupplies_loadtp());

%% input buses
obj = obj.addbus('pcssp_PS_CSPF_volt_cmd', 'pcssp_PowerSupplies_CSPF_volt_busdef' );
obj = obj.addbus('pcssp_PS_VS1_volt_cmd', 'pcssp_PowerSupplies_VS1_volt_busdef');
obj = obj.addbus('pcssp_PS_VS3_volt_cmd', 'pcssp_PowerSupplies_VS3_volt_busdef');
obj = obj.addbus('pcssp_PS_CSPF_curr_meas', 'pcssp_PowerSupplies_CSPF_curr_busdef' );


%% output buses
obj = obj.addbus('pcssp_PS_VCSPF', 'pcssp_PowerSupplies_VCSPF_busdef');
obj = obj.addbus('pcssp_PS_VS1', 'pcssp_PowerSupplies_VS1_busdef');
obj = obj.addbus('pcssp_PS_VS3', 'pcssp_PowerSupplies_VS3_busdef');


%% Tasks

%% Print (optional)
obj.printinfo;

end

