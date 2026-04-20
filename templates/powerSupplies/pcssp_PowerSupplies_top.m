function topm = pcssp_PowerSupplies_top()
% power supplies top model. For now only contains one PCSSP module as
% referenced 


    topm = pcssp_top_class('PS_top');

    obj_PS = pcssp_PowerSupplies_obj();
    topm = topm.addmodule(obj_PS);
end