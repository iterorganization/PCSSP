classdef pcssp_cruise_controller_test < pcssp_module_test
    % test for PCSSP_PID demo module
    % see pcssp_module test class for all standard pcssp module tests
    
    properties
        algoobj = @()pcssp_cruise_controller_obj();
        isCodegen = 1; % flag to trigger module tests for codeGen
    end 

    methods(Test)
        function build_cruise_controller(testCase)

            obj = testCase.algoobj();
            obj.init;
            obj.setup;
            obj.build('auto');

            obj.write_XML

        end

    end
      
        
        
end