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

        function test_param_injection(testCase)
            obj = testCase.topm_obj();
            
            obj.init;
            obj.setup;

            obj_PID = obj.moduleobjlist{1};

            PID = obj_PID.get_nominal_tp_value('pcssp_PID_tp');
            obj_PID.clear_model_ws;

            obj_PID.set_model_argument(PID,'tp');

            obj.set_model_argument_value('PID','tp','PID');

            Simin = Simulink.SimulationInput(obj.name);

            Simin = Simin.setVariable('PID',PID);

            out = sim(Simin);

            testCase.verifyEmpty(out.ErrorMessage);

            
        end
    end
    

    
end