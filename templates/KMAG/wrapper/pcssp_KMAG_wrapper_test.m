classdef pcssp_KMAG_wrapper_test < pcssp_wrapper_test


    properties
        wrapper
    end

    methods
        % class constructor to overwrite isCodegen property of superClass
        function obj = pcssp_KMAG_wrapper_test
            obj.isCodegen = 1;

            obj.wrapper = pcssp_wrapper('pcssp_KMAG_wrapper');
            obj_KMAG = pcssp_KMAG_module_obj();
            obj.wrapper.timing.dt = obj_KMAG.gettiming.dt;
            obj.wrapper = obj.wrapper.addalgo(obj_KMAG);

        end
    end

end