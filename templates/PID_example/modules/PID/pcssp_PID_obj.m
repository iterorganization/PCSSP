function obj = pcssp_PID_obj(n_input)

%% Demonstration algorithm 2
%
%
% [ SCDDS - Simulink Control Development & Deployment Suite ] Copyright SPC-EPFL Lausanne 2022.
% Distributed under the terms of the GNU Lesser General Public License, LGPL-3.0-only.
obj = pcssp_module('pcssp_PID');

%% Timing of the algorithm
obj=obj.settiming(0,1e-3,10.0);

%% Fixed parameters init functions 
obj=obj.addfpinitfcn('pcssp_PID_loadfp','pcssp_PID_fp');

%% Tunable parameters structure name
obj=obj.addtunparamstruct('pcssp_PID_tp', @()pcssp_PID_loadtp());

%% Wavegens
% mdsconfig = SCDDSdemo_mdsconfig();
% obj=obj.addwavegenbasetruct('algo_demo2_inbus1');
% obj=obj.addwavegen(SCDclass_mdswgsigsingle( 'demo2.inputs.signal1','signal1'        ,'srcsrv',mdsconfig.mdsserver,'srctree',mdsconfig.mdstree));
% obj=obj.addwavegen(SCDclass_mdswgsigsingle( 'demo2.inputs.signal2','signal2'        ,'srcsrv',mdsconfig.mdsserver,'srctree',mdsconfig.mdstree));

%% Buses
obj = obj.addbus('', @() pcssp_PID_inBus_def(n_input));
obj = obj.addbus('pcssp_PID_outBus', 'pcssp_PID_outBus_def' );

 % function handle that returns cell arays of buses and busnames to be registered
% obj = obj.addbus('',@() pcssp_PID_signal_buses());

%% Tasks

%% Print (optional)
obj.printinfo;

end

