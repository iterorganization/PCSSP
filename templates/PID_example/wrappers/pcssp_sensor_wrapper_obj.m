function sensor_wrapper = pcssp_sensor_wrapper_obj()

obj_sensor = pcssp_PID_sensor_obj();

sensor_wrapper = pcssp_wrapper('sensor_wrapper');
sensor_wrapper = sensor_wrapper.addalgo(obj_sensor);

end