classdef pcssp_PID_topm_test < pcssp_topmodel_test
    
    properties 
       topm_obj =  @()pcssp_closed_loop_obj(); 
    end
    

    
end