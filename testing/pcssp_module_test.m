classdef (Abstract) pcssp_module_test < SCDDSalgo_test & matlab.unittest.TestCase
    % Abstract class to test pcssp modules
    % Derive from SCDDS core and common test
    
    % PCSSP - Plasma Control System Simulation Platform
    % Copyright ITER Organization 2025
    % Route de Vinon-sur-Verdon, 13115, St. Paul-lez-Durance, France
    % Distributed under the terms of the GNU Lesser General Public License,
    % LGPL-3.0-only
    % All rights reserved.


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

    properties
        
    end

    methods(TestClassSetup)
        % common methods for all tests
        function setup_paths(~) % function to setup desired paths
            rootpath = fileparts(fileparts(mfilename('fullpath')));
            run(fullfile(rootpath,'pcssp_add_paths'));
        end

        function define_testIDs(testCase)
            testCase.checkIDlist = 'UpgradeAdvisorR2024a.txt';

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
                checkIDs = readcell(testCase.checkIDlist);
                result = run_model_advisor(testCase,checkIDs,'configurationSettingsAutocpp','configurations_container_pcssp.sldd');
                % Print error flag to output
                testCase.verifyEqual(result.numFail,0);

            end

        end

        function pcssp_ITER_model_compliance(testCase)

            % This test validates the PCSSP module for compliance against
            % some basic modeling standards as determined by the Simulink
            % advisory board
            checkIDs = readcell('MABcheckIDs.txt');
            result = run_model_advisor(testCase,checkIDs,'pcssp_Simulation','configurations_container_pcssp.sldd'); 
            testCase.verifyEqual(result.numFail,0);


        end

        function run_upgrade_advisor(testCase)
            % To do: This test needs to be dependent on the Matlab version
            % using TestTags

            checkIDs = readcell(testCase.checkIDlist);
            result = run_model_advisor(testCase,checkIDs,'pcssp_Simulation','configurations_container_pcssp.sldd');
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

                    module.build('auto');

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
 
end