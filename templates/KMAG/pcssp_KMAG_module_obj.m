function obj = pcssp_KMAG_module_obj(n_input)

%% Demonstration algorithm 2
%
%
% [ SCDDS - Simulink Control Development & Deployment Suite ] Copyright SPC-EPFL Lausanne 2022.
% Distributed under the terms of the GNU Lesser General Public License, LGPL-3.0-only.
obj = pcssp_module('pcssp_KMAG');

%% Timing of the algorithm
obj=obj.settiming(0,2e-3,10.0);

%% Fixed parameters init functions 
obj=obj.addfpinitfcn('pcssp_KMAG_loadfp','pcssp_KMAG_fp');

%% Tunable parameters structure name
% obj=obj.addtunparamstruct('pcssp_KMAG_tp', @()pcssp_KMAG_loadtp());
obj = obj.addtunparamstruct('pcssp_KMAG_Ke',@()pcssp_KMAG_load_Ke);
obj = obj.addtunparamstruct('pcssp_KMAG_P',@()pcssp_KMAG_load_P);
obj = obj.addtunparamstruct('pcssp_KMAG_I',@()pcssp_KMAG_load_I);
obj = obj.addtunparamstruct('pcssp_KMAG_D',@()pcssp_KMAG_load_D);
obj = obj.addtunparamstruct('pcssp_KMAG_N',@()pcssp_KMAG_load_N);


%% Buses
obj = obj.addbus('pcssp_KMAG_ref', 'pcssp_KMAG_ref_busdef');
obj = obj.addbus('pcssp_KMAG_extFF', 'pcssp_KMAG_extFF_busdef');
obj = obj.addbus('pcssp_KMAG_y', 'pcssp_KMAG_y_busdef');

obj = obj.addbus('pcssp_KMAG_out', 'pcssp_KMAG_out_busdef');


 % function handle that returns cell arays of buses and busnames to be registered
% obj = obj.addbus('',@() pcssp_PID_signal_buses());

%% Tasks

%% Print (optional)
obj.printinfo;

end

