classdef pcssp_PowerSupplies_top_test < pcssp_topmodel_test
    % PCSSP_POWERSUPPLIES_TOP_TEST inherited test class for the
    % powersupplies top model
    
    properties
        topm = @()pcssp_PowerSupplies_obj()
    end
    
    methods
        function obj = pcssp_PowerSupplies_top_test
            %PCSSP_POWERSUPPLIES_TOP_TEST Construct an instance of this class
            topm = pcssp_top_class('PS_top');

            obj_PS = pcssp_PowerSupplies_obj();
            topm = topm.addmodule(obj_PS);
            obj.topm = topm;
        end
        
    end
end

