classdef (Abstract) pcssp_module_test < SCDDSalgo_test & matlab.unittest.TestCase
  % Abstract class to test pcssp modules
  % Derive from SCDDS core and common test
  %
  % SCDDS core already does the following each module:
  % - clear all variables 
  % - force close all sldd's
  % - call module-init
  % - print info
  % - call module setup
  % - update the module .slx (ctrl+D) in Simulink
  % - call the module test harness (if it exists)
  %

  % in this class we add some additional tests for codegen compatibilities
  % etc.
  
  properties(Abstract=true)
     isCodegen
  end
  
  methods(TestClassSetup)
    % common methods for all tests
    function setup_paths(~) % function to setup desired paths
      rootpath = fileparts(fileparts(mfilename('fullpath')));
      run(fullfile(rootpath,'pcssp_add_paths'));
    end
  end
  
  methods(Test)
      function pcssp_ITER_codeGen_compliance(testCase)
            
          % this test is only run when the testCase.isCodegen property is
          % set to true in the inherited class associated wit the PCSPP
          % module
          
          if testCase.isCodegen
          % Create Model Advisor app. Model must exist and be saved
          app = Advisor.Manager.createApplication();
          
          module = testCase.algoobj();
          module.init;
          module.setup;
          
          % Set root for analysis
          setAnalysisRoot(app,'Root', module.modelname);
          
          % Clear all check instances from Model Advisor analysis.
          deselectCheckInstances(app);
          
          % Load and select codegen relevant checks
          IDs = readcell('checkinstanceIDs.txt');
          instanceIDs = getCheckInstanceIDs(app, IDs);
          selectCheckInstances(app, 'IDs', instanceIDs);
          
          %Run Model Advisor analysis.
          run(app);
          
          %Get analysis results.
          result = getResults(app);
          
          % Print error flag to output
          testCase.verifyEqual(result.numFail,0);
          
          end
          
      end
  end
  
  
end