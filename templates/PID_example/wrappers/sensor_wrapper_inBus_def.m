function [busNames,Buses] = sensor_wrapper_inBus_def()

busNames={};
Buses={};

elems(1)=Simulink.BusElement;
elems(1).Name='plantMeasurement1';
elems(1).DataType='Bus: pcssp_TF_outBus';

elems(2)=Simulink.BusElement;
elems(2).Name='plantMeasurement2';
elems(2).DataType='Bus: pcssp_TF_outBus';

elems(3)=Simulink.BusElement;
elems(3).Name='plantMeasurement3';
elems(3).DataType='Bus: pcssp_TF_outBus';

inBus = Simulink.Bus;
inBus.DataScope = 'Auto';
inBus.Alignment = -1;
inBus.Elements = elems;
clear elems;

% append to list
busNames{end+1} = 'sensor_wrapper_inBus';
Buses{end+1}    = inBus; 


end