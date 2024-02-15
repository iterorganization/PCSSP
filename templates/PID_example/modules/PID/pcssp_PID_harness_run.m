function out = pcssp_PID_harness_run(obj)

% initialize object
obj.init;
obj.setup;

pcssp_PID_tp = obj.get_nominal_tp_value('pcssp_PID_tp');

% define waveforms
SimIn = Simulink.SimulationInput([obj.getname '_harness']);
ds = createInputDataset(obj.getname);


input.error = timeseries(5*ones(3,2),[0 10]);
ds = setElement(ds,1,input,'error');

SimIn = SimIn.setExternalInput(ds);

% add mask param
SimIn = setVariable(SimIn,'pcssp_PID_tp',pcssp_PID_tp);

out = sim(SimIn);

end