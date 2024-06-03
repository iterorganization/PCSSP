function [busNames,Buses] = sensor_wrapper_inBus_def()

busNames={};
Buses={};

% init bus
elems(1)=Simulink.BusElement;
elems(1).Name='bla';
elems(1).DataType='single';

inBus = Simulink.Bus;
inBus.DataScope = 'Auto';
inBus.Alignment = -1;
inBus.Elements = elems;
clear elems;

% append to list
busNames{end+1} = 'sensor_wrapper_inBus';
Buses{end+1}    = inBus; 


end