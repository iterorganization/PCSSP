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
        isCodegen logical
    end

    methods(TestClassSetup)
        % common methods for all tests
        function setup_paths(~) % function to setup desired paths
            rootpath = fileparts(fileparts(mfilename('fullpath')));
            run(fullfile(rootpath,'pcssp_add_paths'));
        end
    end

    methods(TestMethodSetup)
        % empty for now
        function clear_workspaces_and_sldds(~)
            disp('clearing workspace, models, and sldds');
            clear;
            bdclose all;
            Simulink.data.dictionary.closeAll('-discard')
        end
    end

    methods(Test)
        function pcssp_ITER_codeGen_compliance(testCase)

            % this test is only run when the testCase.isCodegen property is
            % set to true in the inherited class associated wit the PCSPP
            % module

            if testCase.isCodegen
                checkIDs = readcell('checkinstanceIDs.txt');
                result = run_model_advisor(testCase,checkIDs,'configurationSettingsRTF');
                % Print error flag to output
                testCase.verifyEqual(result.numFail,0);

            end

        end

        function pcssp_ITER_model_compliance(testCase)

            % This test validates the PCSSP module for compliance against
            % some basic modeling standards as determined by the Simulink
            % advisory board
            checkIDs = readcell('MABcheckIDs.txt');
            result = run_model_advisor(testCase,checkIDs,'pcssp_Simulation');
            testCase.verifyEqual(result.numFail,0);


        end


        function harness_SIL_run(testCase)
            module = testCase.algoobj();

            if testCase.isCodegen
                harnessname = sprintf('%s_harness_run',module.modelname);

                if ~exist(harnessname,'file')
                    warning('no harness %s found, skipping test',harnessname);
                    return

                else

                    module.init;
                    module.setup;

                    module.build;

%                     % set SIL mode for referenced model
%                     module.load;
%                     modelInfo = Simulink.MDLInfo([module.modelname, '_harness']);
% 
%                     modelrefname = split(modelInfo.Interface.ModelReferences{1},'|');
% 
% 
%                     set_param(modelrefname{1},'SimulationMode','Software-in-the-loop (SIL)');
% 
%                     
% 
%                     sim();


                end

            end

        end




    end


    %% helper functions
    methods
        function result = run_model_advisor(testCase,checkIDs,configurationSettings)
            % This function runs the Simulink Check 'model advisor' on a
            % selected number of checkIDs

            % Limitations: ModelAdvisor.run does not cross model boundaries
            % and 2) does not run all model variants. We should use
            % Advisor.application for this instead

            % set Simulink Configuration to codegen
            sourcedd = 'configurations_container_pcssp.sldd';


            module = testCase.algoobj();
            module.init;
            module.setup;

            SCDconf_setConf(configurationSettings,sourcedd);

            result = ModelAdvisor.run(module.modelname,checkIDs,'Force','On');
            result = result{1};



        end

    end
end