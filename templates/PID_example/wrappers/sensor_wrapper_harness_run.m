function out = sensor_wrapper_harness_run(obj)

% initialize object
obj.init;
obj.setup;

% define waveforms
SimIn = Simulink.SimulationInput([obj.name '_harness']);
ds = createInputDataset(obj.name);


input = timeseries(5*ones(3,2),[0 10]);
ds = setElement(ds,1,input);

SimIn = SimIn.setExternalInput(ds);

out = sim(SimIn);

end