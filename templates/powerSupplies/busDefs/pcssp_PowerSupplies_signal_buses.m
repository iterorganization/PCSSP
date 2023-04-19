function [busNames,Buses] = pcssp_PowerSupplies_signal_buses()

busNames={};
Buses={};

% init bus
elems(1)=Simulink.BusElement;
elems(1).Name='clipgain1';
elems(1).DataType='single';
elems(2)=Simulink.BusElement;
elems(2).Name='tstart1';
elems(2).DataType='single';
elems(3)=Simulink.BusElement;
elems(3).Name='tstop1';
elems(3).DataType='single';
elems(4)=Simulink.BusElement;
elems(4).Name='enable1';
elems(4).DataType='boolean';

initBus = Simulink.Bus;
initBus.HeaderFile = '';
initBus.Description = '';
initBus.DataScope = 'Auto';
initBus.Alignment = -1;
initBus.Elements = elems;
clear elems;

% append to list
busNames{end+1} = 'algo_PID_init1';
Buses{end+1}    = initBus; 


end
