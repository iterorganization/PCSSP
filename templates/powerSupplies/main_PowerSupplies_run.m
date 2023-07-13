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

%% load and prep test data

PS_logged = load('PS_logged');
ds = Simulink.SimulationData.Dataset;
ds = setElement(ds,1,PS_logged.PS_logged.getElement('CSPF_volt_cmd')); % CSPF_volt_cmd
ds = setElement(ds,2,PS_logged.PS_logged.getElement('CSPF_curr_meas')); % CSPF_curr_meas

Simin = Simulink.SimulationInput('PS_top');
Simin = Simin.setExternalInput(ds);

out = sim(Simin);

%%

logsout = logsout2struct(out.yout);

plot(logsout.time,logsout.VCSPF);

