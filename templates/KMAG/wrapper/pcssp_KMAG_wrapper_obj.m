function wrapper = pcssp_KMAG_wrapper_obj()
wrapper = pcssp_wrapper('pcssp_KMAG_wrapper');
obj_KMAG = pcssp_KMAG_module_obj();
wrapper.timing.dt = obj_KMAG.gettiming.dt;
wrapper = wrapper.addalgo(obj_KMAG);

end