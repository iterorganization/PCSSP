function obj = pcssp_PID_sensor_obj()

%% Demonstration algorithm 2

obj = pcssp_module('pcssp_PID_sensor');

%% Timing of the algorithm
obj=obj.settiming(0,1e-3,10.0);

%% Fixed parameters init functions 
obj=obj.addfpinitfcn('pcssp_PID_sensor_loadfp','pcssp_PID_sensor_fp');

obj = obj.addbus('pcssp_PID_outBus', 'pcssp_PID_outBus_def' );


%% Tasks

%% Print (optional)
obj.printinfo;

end

