function obj = pcssp_KCURR_obj()

%% Demonstration algorithm 2
%
%
% [ SCDDS - Simulink Control Development & Deployment Suite ] Copyright SPC-EPFL Lausanne 2022.
% Distributed under the terms of the GNU Lesser General Public License, LGPL-3.0-only.
obj = pcssp_module('pcssp_KCURR');

%% Timing of the algorithm
obj=obj.settiming(0,1e-3,10.0);

%% Fixed parameters init functions 
obj=obj.addfpinitfcn('pcssp_KCURR_loadfp','pcssp_KCURR_fp');

%% Tunable parameters structure name
obj=obj.addtunparamstruct('KCURR_Vup', @()pcssp_KCURR_loadtp());

%% Print (optional)
obj.printinfo;

end

