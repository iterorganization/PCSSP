classdef pcssp_PowerSupplies_top_test < pcssp_topmodel_test
    % PCSSP_POWERSUPPLIES_TOP_TEST inherited test class for the
    % powersupplies top model
    
    properties
        topm = @()pcssp_PowerSupplies_obj()
    end
    
    methods(Test)
        function obj = pcssp_PowerSupplies_top_test
            %PCSSP_POWERSUPPLIES_TOP_TEST Construct an instance of this class
            topm = pcssp_top_class('PS_top');

            obj_PS = pcssp_PowerSupplies_obj();
            topm = topm.addmodule(obj_PS);
            obj.topm = topm;
        end

        function testModuleUpdateParam(testCase)
            obj = testCase.topm();
            obj.init; obj.setup;
            obj_PS = obj.moduleobjlist{obj.grab_module_ind('pcssp_PowerSupplies')};
            
            % update param in child module
            obj_PS.update_nominal_param_value('PowerSupplies_tp.VS3Vup',2400);
            % re-compile top model
            obj.compile;

            % update the full structure
            tp_temp = obj_PS.get_nominal_param_value('PowerSupplies_tp');
            tp_temp.VS3Vup = 2100;

            obj_PS.update_nominal_param_value('PowerSupplies_tp',tp_temp);
            % update the top model
            obj.compile;
            
            Simin = Simulink.SimulationInput(obj.name);
            out = sim(Simin);


        end
        
    end
end

