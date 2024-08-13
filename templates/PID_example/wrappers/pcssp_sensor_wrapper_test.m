classdef pcssp_sensor_wrapper_test < pcssp_wrapper_test
    
    properties
        wrapper
    end
    
    methods
        function obj = pcssp_sensor_wrapper_test()
            
            obj.wrapper = pcssp_sensor_wrapper_obj();
            obj.isCodegen = 0;
        end

    end

    methods(Test)
        function test_xml_write(testCase)
            testCase.wrapper.init;
            testCase.wrapper.setup;
            testCase.wrapper.write_XML;
            % check succesful creation of XML output file
            testCase.verifyTrue(isfile('sensor_wrapper_params.xml'));

        end

        function test_description_writer(testCase)
            
            testCase.wrapper.init;
            testCase.wrapper.setup;
            string_in = 'This Module does bladiebla with utmost precision';    
            testCase.wrapper = testCase.wrapper.set_wrapper_description(string_in);

            save_system(testCase.wrapper.name); % model needs to be saved to correctly retrieve description field
            
            % check wrapper property is correctly written
            testCase.verifyEqual(testCase.wrapper.description,string_in);
            
            % test model info is correctly updated
            modelInfo = Simulink.MDLInfo(testCase.wrapper.name);
            testCase.verifyEqual(modelInfo.Description,string_in);
            
        end


    end
    
end