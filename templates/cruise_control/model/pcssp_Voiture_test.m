classdef pcssp_Voiture_test < pcssp_module_test
    % test for PCSSP_PID demo module
    % see pcssp_module test class for all standard pcssp module tests
    
    properties
        algoobj = @()pcssp_Voiture_obj();
        isCodegen = 0; % flag to trigger module tests for codeGen
    end  
      
        methods(Test)

        end
        
end