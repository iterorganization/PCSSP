function obj = pcssp_TF_obj()

%% Demonstration algorithm 2
%
%
% [ SCDDS - Simulink Control Development & Deployment Suite ] Copyright SPC-EPFL Lausanne 2022.
% Distributed under the terms of the GNU Lesser General Public License, LGPL-3.0-only.
obj = pcssp_module('pcssp_TF');

%% Timing of the algorithm
obj=obj.settiming(0,1e-3,10.0);

%% Fixed parameters init functions 
obj=obj.addfpinitfcn('pcssp_TF_loadfp','pcssp_TF_fp'); % function name, var name

%% Tunable parameters structure name
obj=obj.addtunparamstruct('pcssp_TF_tp', @()pcssp_TF_loadtp());


%% Buses
obj = obj.addbus('pcssp_TF_inBus', 'pcssp_TF_inBus_def' );
obj = obj.addbus('pcssp_TF_outBus', 'pcssp_TF_outBus_def' );

 % function handle that returns cell arays of buses and busnames to be registered
obj = obj.addbus('',@() pcssp_TF_signal_buses());

%% Tasks

%% Print (optional)
obj.printinfo;

end

