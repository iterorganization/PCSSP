function out = pcssp_Voiture_harness_run(obj)

% initialize object
obj.init;
obj.setup;

% define waveforms
SimIn = Simulink.SimulationInput([obj.getname '_harness']);
ds = createInputDataset(obj.getname);


input.acceleration = timeseries(5*ones(1,2),[0 10]);
ds = setElement(ds,1,input,'acceleration');

SimIn = SimIn.setExternalInput(ds);

out = sim(SimIn);

end