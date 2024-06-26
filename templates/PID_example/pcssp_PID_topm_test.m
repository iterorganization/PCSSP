classdef pcssp_PID_topm_test < pcssp_topmodel_test
    
    properties 
       topm_obj =  @()pcssp_closed_loop_obj(); 
    end

    methods(Test)
        function some_test(testCase)


            [topm,obj_PID,obj_TF,obj_sensor,sensor_wrapper_obj] = pcssp_closed_loop_obj();

            %% Initialize
            topm.init;
            topm.setup;
            % options = simset('SrcWorkspace','current');
            % sim(topm.mainslxname,[],options);
            topm.sim;

        end
    end
    

    
end