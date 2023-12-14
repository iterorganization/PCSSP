function [topm,obj_PID,obj_TF,obj_sensor,sensor_wrapper] = pcssp_closed_loop_obj()

%% configure top model
topm = pcssp_top_class('closed_loop');


%% initialize PCSSP modules
obj_PID = pcssp_PID_obj(3); % input is the size of the inBus
obj_TF = pcssp_TF_obj();
obj_sensor = pcssp_PID_sensor_obj();

%% initialize wrapper
obj_sensor = pcssp_PID_sensor_obj();
            
sensor_wrapper = pcssp_wrapper('pid_wrapper');
sensor_wrapper = sensor_wrapper.addalgo(obj_sensor);

%% add modules and wrappers to top model and call init/setup

topm = topm.addmodule(obj_PID);
topm = topm.addmodule(obj_TF);

topm = topm.addwrapper(sensor_wrapper);

end