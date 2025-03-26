%% main file to run standalone PowerSupplies pcssp module example

% get rid of any zombie variables or sldd's
clear; clc; bdclose all; Simulink.data.dictionary.closeAll('-discard');

%% configure top model
topm = pcssp_top_class('PS_top');

obj_PS = pcssp_PowerSupplies_obj();

%% initialize and setup the top model

topm = topm.addmodule(obj_PS);
topm.init;
topm.setup;

%% call harness

out = topm.sim;

logsout = logsout2struct(out);

plot(logsout.time,logsout.VCSPF);

