function [busNames,Buses] = pcssp_varPID_signal_buses()

busNames={};
Buses={};

% input bus
elems(1)=Simulink.BusElement;
elems(1).Name='error';
elems(1).DataType='double';

elems(2)=Simulink.BusElement;
elems(2).Name='signal';
elems(2).DataType='double';
elems(2).Dimensions = [11];
elems(2).DimensionsMode = 'Fixed';
elems(2).SampleTime = -1;
elems(2).Complexity = 'real';

pcssp_varPID_inBus = Simulink.Bus;
pcssp_varPID_inBus.HeaderFile = '';
pcssp_varPID_inBus.Description = '';
pcssp_varPID_inBus.DataScope = 'Auto';
pcssp_varPID_inBus.Alignment = -1;
pcssp_varPID_inBus.Elements = elems;

% append to list
busNames{end+1} = 'pcssp_varPID_inBus';
Buses{end+1}    = pcssp_varPID_inBus; 


clear elems;

% output bus

elems(1) = Simulink.BusElement;
elems(1).Name = 'controlCmd';
elems(1).Dimensions = 1;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).SampleTime = -1;
elems(1).Complexity = 'real';

elems(2) = Simulink.BusElement;
elems(2).Name = 'out';
elems(2).Dimensions = 11;
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'double';
elems(2).SampleTime = -1;
elems(2).Complexity = 'real';

pcssp_varPID_outBus = Simulink.Bus;
pcssp_varPID_outBus.HeaderFile = '';
pcssp_varPID_outBus.Description = '';
pcssp_varPID_outBus.DataScope = 'Auto';
pcssp_varPID_outBus.Alignment = -1;
pcssp_varPID_outBus.Elements = elems;

% append to list
busNames{end+1} = 'pcssp_varPID_outBus';
Buses{end+1}    = pcssp_varPID_outBus; 


end
