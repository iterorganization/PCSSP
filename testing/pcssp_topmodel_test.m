classdef (Abstract) pcssp_topmodel_test < matlab.unittest.TestCase
    %PCSSP_TOPMODEL_TEST Class to test PCSSP top models

    % PCSSP - Plasma Control System Simulation Platform
    % Copyright ITER Organization 2025
    % Route de Vinon-sur-Verdon, 13115, St. Paul-lez-Durance, France
    % Distributed under the terms of the GNU Lesser General Public License,
    % LGPL-3.0-only
    % All rights reserved.

    %   This class can be used to author tests for integrated 'top models'
    %   in pcssp that combine many modules. It relies on the top_model
    %   class to initialize, setup, and manipulate the top model.
    
    % This class already performs the following basic V&V:
    % - call instance of pcssp_top_model class
    % - topm.init
    % - topm.setup
    % - topm.compile (ctrl+D in simulink)
    % and logs any errors that may arise during those tasks
    
    properties (Abstract = true)
        topm {mustBeA(topm,["function_handle","pcssp_top_class"])}
    end
    
    
    methods(TestClassSetup) % these methods run before any tests in the class
        function clear_base(testCase)
            %Completely erase base WS
            testCase.assertWarningFree(@() evalin('base','clear'));
        end
        
        function clear_sldd(testCase)
            SCDDSclass.clean_dd; % force close all sldd and remove unversioned sldd in the git dir
            testCase.assertEmpty(Simulink.data.dictionary.getOpenDictionaryPaths);
        end
        
        function setup_conf(testCase)
            sourcedd = 'configurations_container_pcssp.sldd';
            
            testCase.assertWarningFree(@() SCDconf_setConf('pcssp_Simulation',sourcedd));
        end
        
        function init_class(testCase)

            if isa(testCase.topm,"function_handle")
                testCase.topm = testCase.topm();
            end
        end
    end
    
    
    
    methods (TestClassTeardown)
        function close_dd(testCase) 
            Simulink.data.dictionary.closeAll('-discard');
        end
        
        function close_bd(testCase)
            bdclose all;
        end
    end
    
    methods (Test)
        
        function test_top_model(testCase)
            disp('### TEST ALGO INIT ###');
            testCase.topm.init; % init data dictionary & fixed params
            disp('### TEST ALGO SETUP ###');
            testCase.topm.setup; % setup tunable parameters
            disp('### TEST ALGO COMPILE ###');
            testCase.topm.compile; % update model (Ctrl-D) Simulink
        end
        
    end
end

