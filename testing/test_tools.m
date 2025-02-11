classdef test_tools < matlab.unittest.TestCase
    %TEST_BUS_CREATION Summary of this class goes here
    %   Detailed explanation goes here
    
    
    methods (TestClassSetup)
        function clear_base(testCase)
            % clear base workspace
            %
            testCase.assertWarningFree(@() evalin('base','clear'));
        end
        
    end
    
    
    methods(Test)
        function test_bus_creator_functions(testCase)
            
            % create dummy struct
            
            a.gain      = 1;
            a.satur     = 10;
            a.bandWidth = 50;

            a.b.iter    = 1;
            a.b.maxiter = 5;
            
            [busNames,busobj] = define_bus_from_struct('',a,'Herz',{},{},'prefix','Mein_','postfix','_Brennt',...
                                        'unit',[{''},{'m'},{'Hz'},{''}]);
            
            % main bus
            testCase.verifyEqual(busNames{2},'Mein_Herz_Brennt');
            testCase.verifyEqual(busobj{2}.Elements(1).Name,'gain');
            testCase.verifyEqual(busobj{2}.Elements(2).Name,'satur');
            testCase.verifyEqual(busobj{2}.Elements(3).Name,'bandWidth');
            
            % nested bus
            testCase.verifyEqual(busNames{1},'Mein_b_Brennt');
            testCase.verifyEqual(busobj{1}.Elements(1).Name,'iter');
            testCase.verifyEqual(busobj{1}.Elements(2).Name,'maxiter');
            

        end
        
        function test_sldd_write(testCase)
            Simulink.data.dictionary.closeAll('-discard');
            delete('Rammstein.sldd');
            variable.gain = 5;
            variable_name = 'Sonne';
            sldd = Simulink.data.dictionary.create('Rammstein.sldd');
            
            write_variable2sldd(variable,variable_name,'Rammstein.sldd','Design Data');
            
            sec = sldd.getSection('Design Data');
            var = sec.getEntry('Sonne').getValue;
            
            testCase.verifyEqual(var.gain,5);
        end
            

        function test_PcsSignal_creator(testCase)
            [busNames,Buses] = PcsSignal(1,'Rammstein','Sonne');

            testCase.verifyEqual(busNames{1},'PcsSignal');
            testCase.verifyEqual(Buses{1}.Description,'Sonne');
            testCase.verifyEqual(Buses{1}.Elements(1).Name,'Rammstein');
            testCase.verifyEqual(Buses{1}.Elements(2).Name,'Quality');
            testCase.verifyEqual(Buses{1}.Elements(3).Name,'Activity');


        end
            

    end
end

