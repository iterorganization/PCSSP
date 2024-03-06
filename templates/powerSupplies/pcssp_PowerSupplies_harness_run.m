function pcssp_PowerSupplies_harness_run(obj)

% initialize obj

obj.init;
obj.setup;

obj.compile;

SimIn = Simulink.SimulationInput([obj.getname '_harness']);
ds = createInputDataset(obj.getname);

PS_logged = load('PS_logged');

in1.CSPF_volt_cmd = PS_logged.PS_logged.getElement('CSPF_volt_cmd');
in2.VS1_volt_cmd = PS_logged.PS_logged.getElement('VS3_volt_cmd');
in3.VS3_volt_cmd = PS_logged.PS_logged.getElement('VS3_volt_cmd');
in4.CSPF_curr_meas = PS_logged.PS_logged.getElement('CSPF_curr_meas');

ds = setElement(ds,1,in1,'CSPF_volt_cmd'); % CSPF_volt_cmd
ds = setElement(ds,2,in2,'VS1_volt_cmd'); % CSPF_curr_meas
ds = setElement(ds,3,in3,'VS3_volt_cmd');
ds = setElement(ds,4,in4,'CSPF_curr_meas');

SimIn = SimIn.setExternalInput(ds);

out = sim(SimIn);


end