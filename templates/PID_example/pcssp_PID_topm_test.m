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

            pcssp_PID2_tp = struct('enable',true,'P', 0,'I',0,'D',0);
            % inject param directly in topm sldd (not saved)
            write_variable2sldd(pcssp_PID2_tp,'pcssp_PID2_tp',topm.ddname,'Design Data')
            topm.sim;

        end

        function test_param_injection(testCase)
            obj = testCase.topm_obj();
            
            obj.init;
            obj.setup;

            obj_PID = obj.moduleobjlist{1};

            PID = obj_PID.get_nominal_param_value('pcssp_PID_tp');
            obj_PID.clear_model_ws;

            obj_PID.set_model_argument(PID,'tp');

            obj.set_model_argument_value('PID1','tp','PID');

            Simin = Simulink.SimulationInput(obj.name);

            Simin = Simin.setVariable('PID',PID);

            out = sim(Simin);

            testCase.verifyEmpty(out.ErrorMessage);

            
        end
    end
    

    
end