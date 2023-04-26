% Bus def for CSPF voltage commands of PowerSupplies module
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'ref';
elems(1).Dimensions = 10;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).SampleTime = -1;
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = '';


pcssp_KMAG_ref = Simulink.Bus;
pcssp_KMAG_ref.HeaderFile = '';
pcssp_KMAG_ref.Description = '';
pcssp_KMAG_ref.DataScope = 'Auto';
pcssp_KMAG_ref.Alignment = -1;
pcssp_KMAG_ref.Elements = elems;
clear elems;
