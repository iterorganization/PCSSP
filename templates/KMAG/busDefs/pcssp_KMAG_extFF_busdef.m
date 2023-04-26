% Bus def for CSPF current measurements of PowerSupplies module
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'extFF';
elems(1).Dimensions = 11;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).SampleTime = -1;
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = '';


pcssp_KMAG_extFF = Simulink.Bus;
pcssp_KMAG_extFF.HeaderFile = '';
pcssp_KMAG_extFF.Description = '';
pcssp_KMAG_extFF.DataScope = 'Auto';
pcssp_KMAG_extFF.Alignment = -1;
pcssp_KMAG_extFF.Elements = elems;
clear elems;