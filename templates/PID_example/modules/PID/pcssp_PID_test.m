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

            obj.set_model_argument(pcssp_PID1_tp,'tp');

            % check that trying to overwrite an existing variable in the
            % model WS with a different class throws an error
            
            testCase.verifyError(@() obj.set_model_argument(Simulink.Parameter(pcssp_PID1_tp),'tp'),?MException)

            % clear the model WS
            obj.clear_model_ws('tp');
            
        end

        function test_write_RTF_XML(testCase)
            
            obj = testCase.algoobj();

            obj.write_XML();

            % check XML exists as a file int the current dir
            testCase.verifyEqual(exist([obj.modelname, '_params.xml'],'file'),2);
        end
        
    end
        
        
end