function obj = pcssp_PID_sensor_obj()

%% Demonstration algorithm 2

obj = pcssp_module('pcssp_PID_sensor');

%% Timing of the algorithm
obj=obj.settiming(0,1e-3,10.0);

%% Fixed parameters init functions 
obj=obj.addfpinitfcn('pcssp_PID_sensor_loadfp','pcssp_PID_sensor_fp');

%% add PcsSignal bus for output
obj = obj.addbus('', @() PcsSignal(1,'PID_sensor','sensor measurement'));


%% Tasks

%% Print (optional)
obj.printinfo;

end

