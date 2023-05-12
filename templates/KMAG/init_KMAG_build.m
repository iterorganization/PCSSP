obj_KMAG = pcssp_KMAG_module_obj();

wrapper_KMAG = pcssp_wrapper('pcssp_KMAG_wrapper');

wrapper_KMAG.timing.dt = obj_KMAG.gettiming.dt;

wrapper_KMAG = wrapper_KMAG.addalgo(obj_KMAG);

%% build

