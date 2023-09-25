function [topm,obj_PID,obj_TF] = pcssp_closed_loop_obj()

%% configure top model
topm = pcssp_top_class('closed_loop');


%% initialize PCSSP modules
obj_PID = pcssp_PID_obj(3); % input is the size of the inBus
obj_TF = pcssp_TF_obj();

%% add modules and wrappers to top model and call init/setup

topm = topm.addmodule(obj_PID);
topm = topm.addmodule(obj_TF);

end