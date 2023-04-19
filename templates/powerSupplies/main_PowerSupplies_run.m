%% main file to run standalone PowerSupplies pcssp module example

% get rid of any zombie variables or sldd's
clear; clc; bdclose all; Simulink.data.dictionary.closeAll('-discard');

%% configure top model
topm = PS_top_class('PS_top');

obj_PS = pcssp_PowerSupplies_obj();

%% initialize and setup obj

obj_PS.init
obj_PS.setup


%% node object
node = pcssp_node_class(1);
node = node.addalgo(obj_PS);


%% Setting node into main expcode obj
topm = topm.setnode(node,1);
topm.init;
topm.setup;

%% load and prep test data

PS_logged = load('PS_logged');
ds = Simulink.SimulationData.Dataset;
ds = setElement(ds,1,PS_logged.PS_logged.getElement('CSPF_volt_cmd')); % CSPF_volt_cmd
ds = setElement(ds,2,PS_logged.PS_logged.getElement('CSPF_curr_meas')); % CSPF_curr_meas

Simin = Simulink.SimulationInput('PS_topmain');
Simin = Simin.setExternalInput(ds);

out = sim(Simin);

%%

logsout = logsout2struct(out.yout);

plot(logsout.time,logsout.VCSPF);

