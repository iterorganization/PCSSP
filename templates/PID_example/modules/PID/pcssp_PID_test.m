classdef pcssp_PID_test < pcssp_module_test
    % test for PCSSP_PID demo module
    % see pcssp_module test class for all standard pcssp module tests
    
    properties
        algoobj = @(n_input)pcssp_PID_obj(1);
        isCodegen = 1; % flag to trigger module tests for codeGen
    end  
    
    methods
        function bla(testCase)
            
        end
        
    end
        
        
end