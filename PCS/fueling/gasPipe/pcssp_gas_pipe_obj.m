function obj = pcssp_gas_pipe_obj(gasType)

%% Demonstration algorithm 2
%
%
% [ SCDDS - Simulink Control Development & Deployment Suite ] Copyright SPC-EPFL Lausanne 2022.
% Distributed under the terms of the GNU Lesser General Public License, LGPL-3.0-only.
obj = pcssp_module('pcssp_gas_pipe');

%% Timing of the algorithm
obj=obj.settiming(0,1e-3,10.0);

%% Fixed parameters init functions 
obj=obj.addfpinitfcn(@(gas)pcssp_gas_pipe_loadfp(gasType),'pcssp_gas_pipe_fp');


%% Print (optional)
obj.printinfo;

end

