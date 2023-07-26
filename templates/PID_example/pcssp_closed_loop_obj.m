function topm = pcssp_closed_loop_obj()

%% configure top model
topm = pcssp_top_class('closed_loop');


%% initialize PCSSP modules
obj_PID = pcssp_PID_obj(3); % input is the size of the inBus
obj_TF = pcssp_TF_obj();

%% initialize PCSSP wrappers

wrapper_PID = pcssp_wrapper('pid_wrapper');
wrapper_PID.timing.dt = obj_PID.gettiming.dt;
wrapper_PID = wrapper_PID.addalgo(obj_PID);

%% add modules and wrappers to top model and call init/setup

topm = topm.addwrapper(wrapper_PID);
topm = topm.addmodule(obj_TF);

end