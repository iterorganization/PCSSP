classdef pcssp_PID_test < pcssp_module_test
    % test for PCSSP_PID demo module
    % see pcssp_module test class for all standard pcssp module tests
    
    properties
        algoobj = @(n_input)pcssp_PID_obj(1);
        isCodegen = 1; % flag to trigger module tests for codeGen
    end  
    
    methods(Test)
        function test_clear_model_WS(testCase)
            import matlab.unittest.constraints.*;
            
            obj = testCase.algoobj();
            obj.init;
            obj.setup;

            pcssp_PID1_tp = obj.get_nominal_param_value('pcssp_PID_tp');

            obj.set_model_argument(Simulink.Parameter(pcssp_PID1_tp),'tp');

            % check that trying to overwrite an existing variable in the
            % model WS with a different class throws an error
            
            testCase.verifyError(@() obj.set_model_argument(pcssp_PID1_tp,'tp'),?MException)

            % clear the model WS
            obj.clear_model_ws('tp');
            
        end

        function test_write_RTF_XML(testCase)
            
            obj = testCase.algoobj();

            obj.write_XML();

            % check XML exists as a file int the current dir
            testCase.verifyEqual(exist([obj.modelname, '_params.xml'],'file'),2);
        end

        function test_update_param(testCase)

            obj = testCase.algoobj();
            obj.init;
            obj.setup;
    

            % write new value to nested param field    
            obj.update_nominal_param_value('pcssp_PID_tp.P',30);

            tp_new = obj.get_nominal_param_value('pcssp_PID_tp');

            testCase.verifyEqual(tp_new.P,30);


            % verify that writing a value to a non-existent field throws an
            % error
            testCase.verifyError(@() obj.update_nominal_param_value('pcssp_PID_tp.K',4),?MException);

            % write a full new struct
            tp_temp = obj.get_nominal_param_value('pcssp_PID_tp');     
            obj.update_nominal_param_value('pcssp_PID_tp',tp_temp);

        end
        
    end
        
        
end