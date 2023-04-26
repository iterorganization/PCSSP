% Bus def for CSPF voltage commands of PowerSupplies module
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'y';
elems(1).Dimensions = 10;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).SampleTime = -1;
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = '';


pcssp_KMAG_y = Simulink.Bus;
pcssp_KMAG_y.HeaderFile = '';
pcssp_KMAG_y.Description = '';
pcssp_KMAG_y.DataScope = 'Auto';
pcssp_KMAG_y.Alignment = -1;
pcssp_KMAG_y.Elements = elems;
clear elems;
