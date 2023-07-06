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
obj=obj.addtunparamstruct('KCURR_P', @()pcssp_KCURR_P_tp());
obj=obj.addtunparamstruct('KCURR_I', @()pcssp_KCURR_I_tp());
obj=obj.addtunparamstruct('KCURR_D', @()pcssp_KCURR_D_tp());

obj=obj.addtunparamstruct('KCURR_KdRef', @()pcssp_KCURR_KdRef_tp());
obj=obj.addtunparamstruct('KCURR_Ke', @()pcssp_KCURR_Ke_tp());
obj=obj.addtunparamstruct('KCURR_Ky', @()pcssp_KCURR_Ky_tp());

obj=obj.addtunparamstruct('KCURR_N', @()pcssp_KCURR_N_tp());
obj=obj.addtunparamstruct('KCURR_Nd', @()pcssp_KCURR_Nd_tp());

obj=obj.addtunparamstruct('KCURR_NegCurSlewRate', @()pcssp_KCURR_NegCurSlewRate_tp());
obj=obj.addtunparamstruct('KCURR_PosCurSlewRate', @()pcssp_KCURR_PosCurSlewRate_tp());

obj=obj.addtunparamstruct('KCURR_Vlow', @()pcssp_KCURR_Vup_tp());
obj=obj.addtunparamstruct('KCURR_Vup', @()pcssp_KCURR_Vup_tp());



%% Print (optional)
obj.printinfo;

end

