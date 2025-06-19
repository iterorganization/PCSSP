function [topm,obj_voiture,obj_controller] = cruise_control_topm_obj()

%% configure top model
topm = pcssp_top_class('cruise_control_topm');


%% initialize PCSSP modules
obj_voiture = pcssp_Voiture_obj(); % input is the size of the inBus
obj_controller = pcssp_cruise_controller_obj();

%% add modules and wrappers to top model

topm = topm.addmodule(obj_voiture);
topm = topm.addmodule(obj_controller);


end