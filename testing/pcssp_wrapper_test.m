classdef pcssp_wrapper_test < SCDDSwrapper_test

    % PCSSP - Plasma Control System Simulation Platform
    % Copyright ITER Organization 2025
    % Route de Vinon-sur-Verdon, 13115, St. Paul-lez-Durance, France
    % Distributed under the terms of the GNU Lesser General Public License,
    % LGPL-3.0-only
    % All rights reserved.

    properties
        isCodegen logical = 0; % optional property to earmark for codegen
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

        function wrapper_harness_run(testCase)

            % prepare wrapper obj
            testCase.wrapper.init;

            testCase.wrapper.setup;

            testCase.wrapper.compile;

            testCase.wrapper.test_harness;

        end


        function wrapper_SIL_run(testCase)

            if testCase.isCodegen
                harnessname = sprintf('%s_harness_run',testCase.wrapper.name);
                
                if ~exist(harnessname,'file')
                    warning('no harness %s found, skipping test',harnessname);
                    return

                else
                    testCase.wrapper.init;
                    testCase.wrapper.setup;

                    testCase.wrapper.build;

%                     Simin = Simulink.SimulationInput(harnessname);
            
                    % overwrite start/stop time to match reference simulation UMC_demo
            
                    % run as SIL
%                     Simin = Simin.setModelParameter('SimulationMode','Software-in-the-loop (SIL)');

%                     sim(Simin);


                end

            end

        end
    end


end