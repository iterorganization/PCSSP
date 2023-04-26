% Bus def for CSPF current measurements of PowerSupplies module
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'u';
elems(1).Dimensions = 11;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).SampleTime = -1;
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = 'A';
elems(1).Description = '';


elems(2) = Simulink.BusElement;
elems(2).Name = 'IC_FB';
elems(2).Dimensions = 11;
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'double';
elems(2).SampleTime = -1;
elems(2).Complexity = 'real';
elems(2).Min = [];
elems(2).Max = [];
elems(2).DocUnits = 'A';
elems(2).Description = '';

elems(3) = Simulink.BusElement;
elems(3).Name = 'PIDinternalSignal';
elems(3).Dimensions = [30];
elems(3).DimensionsMode = 'Fixed';
elems(3).DataType = 'double';
elems(3).SampleTime = -1;
elems(3).Complexity = 'real';
elems(3).Min = [];
elems(3).Max = [];
elems(3).DocUnits = '';
elems(3).Description = '';

elems(4) = Simulink.BusElement;
elems(4).Name = 'errorSignal';
elems(4).Dimensions = [10 1];
elems(4).DimensionsMode = 'Fixed';
elems(4).DataType = 'double';
elems(4).SampleTime = -1;
elems(4).Complexity = 'real';
elems(4).Min = [];
elems(4).Max = [];
elems(4).DocUnits = 'T';
elems(4).Description = '';

pcssp_KMAG_out = Simulink.Bus;
pcssp_KMAG_out.HeaderFile = '';
pcssp_KMAG_out.Description = '';
pcssp_KMAG_out.DataScope = 'Auto';
pcssp_KMAG_out.Alignment = -1;
pcssp_KMAG_out.Elements = elems;
clear elems;