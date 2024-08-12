classdef pcssp_PID_topm_test < pcssp_topmodel_test
    
    properties 
       topm_obj =  @()pcssp_closed_loop_obj(); 
    end

    methods(Test)


        function test_param_injection(testCase)
            obj = testCase.topm_obj();
            
            obj.init;
            obj.setup;

            obj_PID = obj.moduleobjlist{1};
            obj_PID.clear_model_ws;

            % create a mask variable for PID2 and PID3 with gains

            pcssp_PID1_tp = obj_PID.get_nominal_param_value('pcssp_PID_tp');
            pcssp_PID2_tp = struct('enable',true,'P', 0,'I',0,'D',0);
            pcssp_PID3_tp = struct('enable',true,'P', 0,'I',0,'D',0);
            % inject param directly in topm sldd (not saved)
            write_variable2sldd(pcssp_PID2_tp,'pcssp_PID2_tp',obj.ddname,'Design Data');
            write_variable2sldd(pcssp_PID3_tp,'pcssp_PID3_tp',obj.ddname,'Design Data');

            obj_PID.set_model_argument(pcssp_PID1_tp,'tp');

            obj.set_model_argument_value('PID1','tp','pcssp_PID1_tp');
            obj.set_model_argument_value('PID2','tp','pcssp_PID2_tp');
            obj.set_model_argument_value('PID3','tp','pcssp_PID3_tp');

            Simin = Simulink.SimulationInput(obj.name);

            Simin = Simin.setVariable('pcssp_PID1_tp',pcssp_PID1_tp);
            Simin = Simin.setVariable('pcssp_PID2_tp',pcssp_PID2_tp);
            Simin = Simin.setVariable('pcssp_PID3_tp',pcssp_PID3_tp);

            out = sim(Simin);

            testCase.verifyEmpty(out.ErrorMessage);

            
        end
    end
    

    
end