function sensor_wrapper = pcssp_sensor_wrapper_obj()


obj_sensor = pcssp_PID_sensor_obj();
obj_tf = pcssp_TF_obj();

sensor_wrapper = pcssp_wrapper('sensor_wrapper',1e-3);
sensor_wrapper = sensor_wrapper.addalgo(obj_sensor);
sensor_wrapper = sensor_wrapper.addalgo(obj_tf);

end