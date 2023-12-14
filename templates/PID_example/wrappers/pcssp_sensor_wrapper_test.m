classdef pcssp_sensor_wrapper_test < SCDDSwrapper_test
    
    properties
        wrapper
    end
    
    methods
        function obj = pcssp_sensor_wrapper_test(obj)
            obj_sensor = pcssp_PID_sensor_obj();
            
            obj.wrapper = pcssp_wrapper('pid_wrapper');
            obj.wrapper = obj.wrapper.addalgo(obj_sensor);
        end
    end
    
end