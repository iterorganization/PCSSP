classdef pcssp_wrapper_test < SCDDSwrapper_test

    properties
        wrapper
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
    end


end